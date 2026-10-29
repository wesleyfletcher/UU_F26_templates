# %%

from pathlib import Path
import re

import music21


import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import networkx as nx


def chord_order(chord_symbol):
    """Sort roots C, G, D, A, E, B, F#/Gb, Db, Ab, Eb, Bb, F."""
    chord = music21.harmony.ChordSymbol(chord_symbol)
    fifth_position = (7 * chord.root().pitchClass) % 12
    quality_position = {
        'major': 0, 'minor': 1, 'diminished': 2, 'augmented': 3,
    }.get(chord.quality, 4)
    return fifth_position, quality_position, chord_symbol


def state_order(state):
    # For chord pairs, group by the newest chord, then the preceding chord.
    return tuple(chord_order(chord) for chord in reversed(state.split()))


def plot_transition_heatmap(probabilities, states):
    """Plot states already sorted by state_order, with root block boundaries."""
    root_positions = [chord_order(state.split()[-1])[0] for state in states]
    boundaries = [0] + [i for i in range(1, len(states))
                        if root_positions[i] != root_positions[i-1]] + [len(states)]
    paired_states = len(states[0].split()) > 1
    fig, ax = plt.subplots(figsize=(14, 12))
    sns.heatmap(probabilities,
                cmap='Blues',
                square=True,
                xticklabels=False if paired_states else states,
                yticklabels=False if paired_states else states,
                cbar_kws={'label': 'Transition Probability'},
                ax=ax)

    # Hundreds of pair labels overlap; label the twelve root blocks instead.
    if paired_states:
        root_labels = ['C', 'G', 'D', 'A', 'E', 'B', 'F#/Gb',
                       'Db', 'Ab', 'Eb', 'Bb', 'F']
        centers = [(start + end) / 2
                   for start, end in zip(boundaries, boundaries[1:])]
        labels = [root_labels[root_positions[start]] for start in boundaries[:-1]]
        ax.set_xticks(centers, labels)
        ax.set_yticks(centers, labels)

    for boundary in boundaries[1:-1]:
        ax.axhline(boundary, color='gray', linewidth=0.6)
        ax.axvline(boundary, color='gray', linewidth=0.6)

    title = 'Second-order' if paired_states else 'First-order'
    ax.set_title(f'{title} Transition Probabilities — Circle of Fifths')
    detail = ' (root of newest chord in pair)' if paired_states else ''
    ax.set_xlabel(f'To State{detail}')
    ax.set_ylabel(f'From State{detail}')
    ax.tick_params(axis='x', labelrotation=90, labelsize=9 if paired_states else 7)
    ax.tick_params(axis='y', labelrotation=0, labelsize=9 if paired_states else 7)
    fig.tight_layout()
    plt.show()


def write_and_play(stream, file_suffix = ""):
    stream.write('midi', fp=f'./music{file_suffix}.mid')
    try:
        stream.show('midi')
    except (music21.exceptions21.Music21Exception, OSError) as error:
        print(f'MIDI saved to music.mid; playback unavailable: {error}')

## Load and clean data:

cols = ['song','time',
        '1','2','3','4','5','6','7','8','9','10','11','12',
        'root','what','chord']
bach = pd.read_csv('./data/bach.data',
                   header=None,
                   names = cols)
bach = bach.loc[:,['song','time','chord']]
bach.head(10)

seq = []
songs = bach['song'].unique()
for song in songs: # Cleans up the chord symbols for music21
    df_s = bach.loc[ bach['song']==song, :]
    lt = list(df_s['chord'])
    lt = [ re.sub(r' ','', ch) for ch in lt]
    lt = [ re.sub(r'_','', ch) for ch in lt]
    lt = [ re.sub(r'M','', ch) for ch in lt]
    lt = [ re.sub(r'b','-', ch) for ch in lt]
    lt = [ re.sub(r'd','dim', ch) for ch in lt]
    lt = [ re.sub(r'dim6','dim', ch) for ch in lt]
    lt = [ re.sub(r'm4','m', ch) for ch in lt]
    seq.append( lt )

bach = seq


# %%

## Determine state space:
states = set()
for song in bach:
    states = states.union( set(song) )
states = sorted(states, key=state_order)

print('States:\n', np.array(states) )


# %%

## Play the state space
stream = music21.stream.Stream()
for chord_symbol in states:
    chord = music21.harmony.ChordSymbol(chord_symbol)
    chord.duration = music21.duration.Duration(1.0)  
    stream.append(chord)
write_and_play(stream, file_suffix="_state_space")

#%%

# An authentic Bach chorale
stream = music21.stream.Stream()
for chord_symbol in bach[5]:
    chord = music21.harmony.ChordSymbol(chord_symbol)
    chord.duration = music21.duration.Duration(2.0)  
    stream.append(chord)
write_and_play(stream, file_suffix="bach_5")


# %%

## Create a S X S transition matrix, and find the transition counts:

S = len(states)
T = len(bach)
tr_counts = np.zeros( (S, S) )

## Compute transition counts:
for song in bach:
    seq = np.array(song)
    for t in range(1,len(seq)):
        # Current and next tokens:
        x_tm1 = seq[t-1] # previous state
        x_t = seq[t] # current state
        # Determine transition indices:
        index_from = states.index(x_tm1)
        index_to = states.index(x_t)
        # Update transition counts:
        tr_counts[index_from, index_to] += 1

print('Transition Counts:\n', tr_counts)

# Sum the transition counts by row:
sums = tr_counts.sum(axis=1, keepdims=True)
print('State proportions: \n')

# Normalize the transition count matrix to get proportions:
tr_pr = np.divide(tr_counts, sums, 
                             out=np.zeros_like(tr_counts), 
                             where=sums!=0)

print('Transition Proportions:\n')

tr_df = pd.DataFrame(np.round(tr_pr,2), index=states, columns=states)
print(tr_df)

plot_transition_heatmap(tr_pr, states)





# %%

## Random chords:
random_pr = tr_counts.sum(axis=0)/tr_counts.sum()

np.random.seed(100) 
initial_state = np.random.choice(states) # Choose an initial state at random
state_index = states.index(initial_state) # Get the index of the initial state
print(f'Initial state: {initial_state}') 
n_sim = 20

simulation = [initial_state]
for t in range(n_sim-1): 
    state_index = np.random.choice(len(states), p=random_pr) # Choose new state index
    simulation.append(states[state_index]) # Append new state to simulation
print(simulation)

new_chorale = [state.split()[-1] for state in simulation] # Convert to chords

# New random chorale
stream = music21.stream.Stream()
for chord_symbol in new_chorale:
    chord = music21.harmony.ChordSymbol(chord_symbol)
    chord.duration = music21.duration.Duration(2.0)  
    stream.append(chord)
write_and_play(stream, file_suffix="_simulated")





# %%

G = nx.from_numpy_array(tr_pr, create_using=nx.DiGraph())

# Check if strongly connected (every chord can reach every other chord)
is_strongly_connected = nx.is_strongly_connected(G)
print(f"Connected: {is_strongly_connected}")

# Get connected components if not connected
if not is_strongly_connected:
    strong_components = list(nx.strongly_connected_components(G))
    print(f"Number of strongly connected components: {len(strong_components)}")




# %%

## Order 2 Markov transitions:

order = 2
songs = []
for song in bach:
    T = len(song)
    entry = [' '.join(song[t:t+order]) for t in range(T-order+1)]
    songs.append(entry) 

states = set()
for song in songs:
    states = states.union( set(song) )
states = sorted(states, key=state_order)

print('States:\n', np.array(states) )

S = len(states)
tr_counts = np.zeros( (S, S) )

# Rows are source states; columns are destination states.
for song in songs:
    seq = np.array(song)
    for t in range(1,len(seq)):
        x_tm1 = seq[t-1] # previous state
        x_t = seq[t] # current state
        index_from = states.index(x_tm1)
        index_to = states.index(x_t)
        tr_counts[index_from, index_to] += 1

sums = tr_counts.sum(axis=1, keepdims=True)
state_props = sums.ravel()/np.sum(sums)

# Normalize each source state's outgoing transitions.
tr_pr = np.divide(tr_counts, sums, 
                 out=np.zeros_like(tr_counts), 
                 where=sums!=0)
print('\nTransition Proportions:\n', tr_pr)


# %%

plot_transition_heatmap(tr_pr, states)


# %%

## Connected?

G = nx.from_numpy_array(tr_pr, create_using=nx.DiGraph())

# Check if strongly connected (every chord can reach every other chord)
is_strongly_connected = nx.is_strongly_connected(G)
print(f"Strongly connected: {is_strongly_connected}")

# Check if weakly connected (ignoring edge direction)
is_weakly_connected = nx.is_weakly_connected(G)
print(f"Weakly connected: {is_weakly_connected}")

# Get connected components if not connected
if not is_strongly_connected:
    strong_components = list(nx.strongly_connected_components(G))
    print(f"Number of strongly connected components: {len(strong_components)}")


# %%

## Generate new music:

np.random.seed(10000) # Favorite
#np.random.seed(5000) 
initial_state = np.random.choice(states) # Choose an initial state at random


initial_state = 'E B'
#initial_state = 'Am Dm'


state_index = states.index(initial_state) # Get the index of the initial state
print(f'Initial state: {initial_state}') 

n_sim = 20

simulation = [initial_state]
for t in range(n_sim-1): 
    pr_t = tr_pr[state_index, :] # Outgoing probabilities from this state
    if not np.any(pr_t):
        print(f'No observed transitions from {states[state_index]}; ending chorale.')
        break
    state_index = np.random.choice(len(states), p=pr_t) # Choose new state index
    simulation.append(states[state_index]) # Append new state to simulation

print(simulation)

new_chorale = simulation[0].split() + [state.split()[-1] for state in simulation[1:]]

# New Bach chorale
stream = music21.stream.Stream()
for chord_symbol in new_chorale:
    chord = music21.harmony.ChordSymbol(chord_symbol)
    chord.duration = music21.duration.Duration(2.0)  
    stream.append(chord)
write_and_play(stream, file_suffix="_simulated_order2")

# %%
