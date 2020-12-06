macro "Track_And_Crop" {	
	// track cells manually, then crop and generate aligned images
	// author: Taihei Fujimori
	
	// ------- tracking ------- //
	Stack.getDimensions(width, height, channels, slices, MAXFR);
	Stack.getPosition(channel, slice, frame2);
	xpos = newArray(MAXFR);
	ypos = newArray(MAXFR);
	zpos = newArray(MAXFR);
	for(i=0;i<xpos.length;i++){
	  	xpos[i] = getHeight()+1;
	  	ypos[i] = getWidth()+1;
		}
	flags2 = 0;      
	ftracked = 0;
	logOpened = false;
	if (getVersion>="1.37r")
	  setOption("DisablePopupMenu", true);
	print("close this window after tracking is finished.");
	while (!logOpened || isOpen("Log")) {
	  logOpened = true;
	  getCursorLoc(x, y, z, flags);
	  Stack.getPosition(channel, slice, frame);
	  if (flags!=flags2 && flags!=0) {
	  	xpos[frame-1] = x;
	  	ypos[frame-1] = y;
	  	zpos[frame-1] = frame;
	  	Stack.setFrame(minOf(frame+1,MAXFR));
	    ftracked=maxOf(frame,ftracked);
	  }
	  if(frame != frame2){
	  	makePoint(xpos[frame-1], ypos[frame-1]);
		  }
		  frame2=frame;
	  flags2=flags;
	  wait(10);
	}
	
	// ------- define the width of cropped area ------- //
	decision = "change width";
	width = 50;
	items = newArray("change width", "go with this");
	while (decision == "change width") {
	  Dialog.createNonBlocking("Area Size");
	  Dialog.addSlider("Width:", 1, minOf(getHeight,getWidth), width);
	  Dialog.show();
	  width = Dialog.getNumber();
	  w = round(width/2);
	  Stack.getPosition(channel, slice, frame);
	  makeRectangle(xpos[frame-1]-w, ypos[frame-1]-w, width, width);  	
	
	      Dialog.createNonBlocking("Area Size");
	      Dialog.addRadioButtonGroup("", items, 2, 1, "change width");
	  Dialog.show();
	  decision = Dialog.getRadioButton();
		}
	
	// ------- generate cropped image ------- //
	title = getTitle;
	id = getImageID();
	imarg = "";
	for(i=1;i<=ftracked;i++){
		 selectImage(id);
		 Stack.setFrame(i);
		 makeRectangle(xpos[i-1]-w, ypos[i-1]-w, width, width);  	
		 run("Duplicate...","slice");
		 rename("crop_"+i);
		 txt = "image"+i+"=crop_"+i+" ";
		 imarg = imarg+txt;
	 	 setBatchMode("hide");
		}
	txt = "image"+i+1+"[-- None --]";
	imarg = imarg+txt;	
	run("Concatenate...", imarg);
	rename("TrackAndCrop_"+title);
	setBatchMode("show");

	for(i=0;i<ftracked;i++){
		setResult("frame", i, zpos[i]);
		setResult("X", i, xpos[i]);
		setResult("Y", i, ypos[i]);
	}
}
