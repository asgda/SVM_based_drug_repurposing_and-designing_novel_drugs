#!/usr/bin/env python

# code for displaying multiple images in one figure

#import libraries
import cv2
from matplotlib import pyplot as plt

# create figure
fig = plt.figure(figsize=(30, 30))

# setting values to rows and column variables
rows = 2
columns = 3

# reading images
Image1 = cv2.imread('ABCA13/actual_vs_pred_24866313_ABCA13.jpeg')
Image2 = cv2.imread('ABCA13/actual_vs_pred_46926350_ABCA13.jpeg')
Image3 = cv2.imread('DNAH9/actual_vs_pred_46236925_DNAH9.jpeg')
Image4 = cv2.imread('DNAH9/actual_vs_pred_5978_DNAH9.jpeg')
Image5 = cv2.imread('/home2/QSAR_check/mutation_analysis/DNAH6/actual_vs_pred_56962337_DNAH6.jpeg')
Image6 = cv2.imread('FLG/actual_vs_pred_234820_FLG.jpeg')
#Image7 = cv2.imread('desc_calc_APC2D9_O_I_SW1417.jpeg')

# Adds a subplot at the 1st position
fig.add_subplot(rows, columns, 1)

# showing image
plt.imshow(Image1)
plt.axis('off')
#plt.title("First")

# Adds a subplot at the 2nd position
fig.add_subplot(rows, columns, 2)

# showing image
plt.imshow(Image2)
plt.axis('off')
#plt.title("Second")

# Adds a subplot at the 3rd position
fig.add_subplot(rows, columns, 3)

# showing image
plt.imshow(Image3)
plt.axis('off')
#plt.title("Third")

# Adds a subplot at the 4th position
fig.add_subplot(rows, columns, 4)

# showing image
plt.imshow(Image4)
plt.axis('off')
#plt.title("Fourth")

# Adds a subplot at the 5th position
fig.add_subplot(rows, columns, 5)

# showing image
plt.imshow(Image5)
plt.axis('off')
#plt.title("Fourth")

# Adds a subplot at the 6th position
fig.add_subplot(rows, columns, 6)

# showing image
plt.imshow(Image6)
plt.axis('off')
#plt.title("Fourth")

# Adds a subplot at the 7th position
#fig.add_subplot(rows, columns, 7)

# showing image
#plt.imshow(Image7)
#plt.axis('off')
#plt.title("Fourth")

# Adjust the spacing between subplots
plt.subplots_adjust(wspace=0, hspace=0)

# Save the merged figure
plt.savefig('merged_images_mut_drug_onc.jpeg', bbox_inches='tight')

# Show the merged figure
plt.show()

