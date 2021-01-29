setBatchMode(true);

savedir = getDirectory("Choose where to Save Kymographs "); // choose where to save
registered_image_id=getImageID(); //get ID of original image
selectImage(registered_image_id);
moviename=getTitle(); //get title of original file
run("Split Channels"); //split the channels
blue = getImageID(); // this part is a little crazy..orignally were using a 3 channel image..
red = blue+2 ; //assign ids
green = blue+1; //assign ids




/*
names = newArray(nImages); 
ids = newArray(nImages); 
for (i=0; i < ids.length; i++){ 
        selectImage(i+1); 
        ids[i] = getImageID(); 
        names[i] = getTitle(); 
        print(ids[i] + " = " + names[i]); 
} 
*/







for(i=0;i<roiManager("count");i++){ //iterate over all the rois

selectImage(green);     //make the green channel montage
//waitForUser();

roiManager("Select", i);
selectImage(green);
run("Multi Kymograph","linewidth=1");   //HERE YOU CAN CHANGE THE LINEWIDTH
grkymo=getImageID();
selectImage(grkymo);
run("Red");
rename("rdkymo");

//waitForUser();

selectImage(red);   // do the same for red
roiManager("Select", i);
selectImage(red);
run("Multi Kymograph","linewidth=1"); // HERE YOU CAN CHANGE THE LINEWIDTH
rdkymo=getImageID();
selectImage(rdkymo);
run("Green");
rename("grkymo");

//waitForUser();

selectImage(blue);   // do the same for blue
roiManager("Select", i);
selectImage(blue);
run("Multi Kymograph","linewidth=1"); // HERE YOU CAN CHANGE THE LINEWIDTH
blkymo=getImageID();
selectImage(blkymo);
run("Blue");
rename("blkymo");

run("Merge Channels...","c1=grkymo c2=rdkymo c3=blkymo "); // Merge the channels

selectImage("RGB");
saveAs("Tiff", savedir+moviename+"tube"+i);


}

selectImage(green);
close();
selectImage(red);
close();
selectImage(blue);
close();


run("Images to Stack","method=[Copy (center)] name=Stack title=[] use");
run("Make Montage...");
saveAs("Tiff", savedir+moviename+"Montage.tif");





