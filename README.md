# Track And Crop
An imageJ macro to track cells manually and generate cropped-and-aligned images.  

## DEMO
<div align="center">
<img src="https://user-images.githubusercontent.com/40162543/101270347-ed0be300-372c-11eb-8f95-05aaee374af7.gif" width="70%">
</div>

## Installation
1. Install imageJ, create 'myscripts' folder in 'plugins' folder.
2. Put 'Track_And_Crop.ijm' in the folder.
3. Start ImageJ.
4. You will be able to see 'myscripts' tab in the Plugin menu. 

## How to use
1. This macro works for stacked image sequence.  
2. Click 'Track And Crop' in myscripts tab under the Plugin menu.  A Log window that says "close this window after tracking is finished" will pop up.  
3. Track cells manually by clicking cells.  The image automatically goes to next slice when you click.  
4. After tracking cells, look back the tracked position and correct the positions by clicking a correct position.  
5.  Close the Log window.  
6. Area Size window will automatically show up.  You can change the width of cropped image.  After clicking OK, you can check the window size and might want to change the width by selecting "change width" or determine it by selecting "go with this".  
7. A new image sequence will be generated in the window size at the tracked positions.  Also you will get the coordinate in the Results window that you can save as csv.  

## Reference  
The movie in the demo is live-imaging of CHO cells expressing H2B-mCitrine published in [Bintu L, Yong J *et al.*, *Science*, 2016.](https://science.sciencemag.org/content/351/6274/720)