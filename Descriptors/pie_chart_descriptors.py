#!/usr/bin/env python

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import gridspec

# Read the data into a DataFrame
data = pd.read_csv('java_class_all_cl.csv')

# Count the frequencies and calculate percentages
value_counts = data['Class_new'].value_counts()
percentages = (value_counts / len(data)) * 100

# Sort the data by frequency
sorted_data = percentages.sort_values(ascending=False)

labels = sorted_data.index

# Set custom colors for the pie chart
#colors = ["#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#FD8D3C", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854"]
colors = ["#8B00FF", "#4B0082", "#0000FF", "#008000", "#FFFF00", "#FFA500", "#FF0000", "#8B0000", "#FF69B4", "#FF1493", "#FF00FF", "#800080", "#9400D3", "#9370DB"] #VIBGYOR color scheme

# Create a pie chart
fig = plt.figure(figsize=(10, 10))
gs1 = gridspec.GridSpec(1, 1, left=0.1, right=0.7, bottom=0.1, top=0.7)

pie_ax = fig.add_subplot(gs1[0])

wedges, _ = pie_ax.pie(
    sorted_data,
    shadow=False,
    colors=colors,
    startangle=0,
    explode=(0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1),
    wedgeprops={'linewidth': 1, 'edgecolor': 'black'} # Rotate the pie chart to 0 degrees
)

# Define the uniform distance from the center
distance = 1.15

# Add labels just outside the pie chart with uniform distance
for i, (label, pct) in enumerate(zip(labels, sorted_data)):
    ang = (wedges[i].theta2 - wedges[i].theta1) / 2.0 + wedges[i].theta1
    y = distance * np.sin(np.deg2rad(ang))
    x = distance * np.cos(np.deg2rad(ang))
    
    horizontalalignment = {-1: "right", 1: "left"}[int(np.sign(x))]
    
    plt.text(x, y, f'{label} ({pct:.2f}%)', horizontalalignment=horizontalalignment, fontsize=11)

pie_ax.axis('equal')
#plt.title("Descriptors", fontweight="bold", size=35)
fig.savefig('pie_chart.tif', dpi=300, bbox_inches='tight')
plt.show()
