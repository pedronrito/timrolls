import processing.pdf.*;
// import de.voidplus.leapmotion.*;

// LeapMotion leap;

boolean record = false;
boolean flipX = true;
boolean flipY = true;

HDrawablePool pool;
HDrawablePool pool2;
HDrawablePool pool3;
HDrawablePool pool4;
HDrawablePool pool5;

HPolarLayout layout;

HTimer timer;
HColorPool colors;
HColorPool colors2;

HPixelColorist pcolors;
HColorField colorField;

HCanvas canvas;

PShader flipHalf;
PShader flipHalfY;

void setup(){
	size(displayWidth-200,displayHeight-200, OPENGL);
	frameRate(30);

	PImage bg= loadImage("Cloudbank_Grad.jpg");
	bg.resize(width,height);
	// H.init(this).use3D(true).background(#85f8ff);
	H.init(this).use3D(true).backgroundImg(bg);

	smooth();

	// leap = new LeapMotion(this);

	blendMode(SCREEN);

	canvas = (HCanvas)H.add(new HCanvas(OPENGL).autoClear(false).fade(6));
	H.add(canvas);

	flipHalf = loadShader("flipHalf.glsl");
	flipHalfY = loadShader("flipHalfY.glsl");

	// H.add(new HRect(1000).fill(#e7e7e7));

	// HImage BG = new HImage("BG.jpg");
	// H.add(BG).anchorAt(H.CENTER).locAt(H.CENTER).size(1500).z(-1);

	// //rotate Background
	// new HOscillator()
	// 	.target(BG)
	// 	.property(H.ROTATION)
	// 	.range(-180, 180)
	// 	.speed(.3)
	// 	.freq(2)
	// 	// .waveform(H.SAW)
	// 	// .currentStep(i)
	// ;

	// HImage hitObj2 = new HImage("cloudy4.png");
	// H.add(hitObj2).anchorAt(H.CENTER).loc(650,600).rotation(00).size(1000).visibility(false);
	// hsl2 = new HShapeLayout().target(hitObj2);

	// PImage bg= loadImage("Cloudbank_BG.jpg");
	// bg.resize(width,height);
	// pcolors= new HPixelColorist(bg)
	// .fillOnly()
	// // .strokeOnly()
	// // .fillAndStroke()
	// ;

	// colorField = new HColorField(width, height)
	// 	.addPoint(0, height/2, #ff0066, 0.5f)
	// 	// .addPoint(width/2, height-200, #3300FF, 0.3f)
	// 	.addPoint(width/2, 0, #00ff2f, 0.2f)
	// 	.addPoint(width/2, height/2, #fff195, 0.2f)
	// 	// .fillOnly()
	// 	.strokeOnly()
	// 	// .fillAndStroke()
	// ;


	colors2 = new HColorPool()

		.add(#ffffff) //white
		.add(#FF7214,5) //grey
		.add(#dee7ff)
		.add(#bce8ef)
		// .fillOnly()
	;

	colors = new HColorPool()
		.add(#bbe8d4,2)  //green
		.add(#48225f,3) //purple
		.add(#eb7d96,2) //pink
		.add(#ffffff,10)
		.fillOnly()
	;



	pool = new HDrawablePool(20); //Shapes
	// pool.autoAddToStage()
	pool.autoParent(canvas)


		.add (new HShape("process1.svg").enableStyle(false))
		.add (new HShape("process2.svg").enableStyle(false))
		.add (new HShape("process3.svg").enableStyle(false))
		.add (new HShape("process4.svg").enableStyle(false))
		.add (new HShape("process5.svg").enableStyle(false))
		.add (new HShape("process2.svg").enableStyle(false))
		// .add(new HRect(1))
		// .add(new HEllipse(10))						
		// .add ( new HPath().polygon(3) )
		// .add ( new HPath().polygon(6) )

		// .layout(
		// 	new HGridLayout()
		// 	.cols(35)
		// 	.spacingX(20)
		// 	.spacingY(10)
		// 	.startX(160)
		// 	.startY(160)
		// )

		// .layout(
		// 	new HHexLayout()

		// 	.spacing(15)
		// 	.offsetX(0)
		// 	.offsetY(0)
		// )

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HDrawable d = (HDrawable) obj;
					d
						// .enableStyle(false)
						// .strokeJoin(ROUND)
						// .strokeCap(ROUND)
						// .strokeWeight(1)
						// .stroke(#000000)
						// .noFill()
						.fill(colors2.getColor(),150)
						.noStroke()
						// .anchorAt(H.CENTER)
						.anchor(random(-100,100),random(-100,100))
						// .rotate( (int)random(4) * 90 )
						// .size((int)random(1,3)*100)
						.x(random(0,width/2))
						.y(height/2)
						.size( ( (int)random(1,4) * 50 ) ) // 50, 100, 150, 200
					;
					// d.randomColors(colors.fillOnly());
					// layout.applyLayout(d);
					// pcolors.applyColor(d);

					new HOscillator()
						.target(d)
						.property(H.SIZE)
						.range(20, 250)
						.speed(random(0.1,2))
						.freq(random(8))
						// .waveform(H.SAW)
						.currentStep(i+10)
					;

					new HOscillator()
						.target(d)
						.property(H.Z)
						.range(0, 200)
						.speed(random(2))
						.freq(random(8))
						.waveform(H.SAW)
						.currentStep(i)
					;

					// new HOscillator()
					// 	.target(d)
					// 	.property(H.WIDTH)
					// 	.range(5, 300)
					// 	.speed(.1)
					// 	.freq(random(4))
					// 	// .waveform(H.SAW)
					// 	// .currentStep(i+10)
					// ;

					new HOscillator()
						.target(d)
						.property(H.X)
						.range(random(width/2), width-500)
						.speed(random(0.1,1.5))
						.freq(random(3))
						.waveform(H.SAW)
						// .currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.range(300, height-300)
						.speed(random(0.1,1))
						.freq(random(4))
						// .waveform(H.SAW)
						.currentStep(i+120)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONX)
						.range(-60, 60)
						.speed(.2)
						.freq(random(3))
						// .waveform(H.TRIANGLE)
						.currentStep(i+100)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONY)
						.range(-30, 30)
						.speed(.2)
						.freq(3)
						// .waveform(H.SAW)
						// .currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONZ)
						.range(-360, 0)
						.speed(.2)
						.freq(random(2,5))
						// .waveform(H.SAW)
						.currentStep(i)
					;

					
				}
			}
		)
		.requestAll()
	;




	pool2 = new HDrawablePool(256); //Triangles 
	// pool.autoAddToStage()
	pool2.autoParent(canvas)
		// .add(new HShape("tetris1.svg"))
		// .add(new HShape("tetris2.svg"))
		// .add(new HShape("tetris3.svg"))
		// .add(new HShape("cloudbank3.svg"))
		// .add(new HShape("cloudbank4.svg"))
		// .add(new HShape("cloudbank5.svg"))
		// .add (new HShape("doodle4.svg").anchorAt(H.CENTER))
		// .add (new HShape("doodle5.svg").anchorAt(H.CENTER))

		// .add(new HShape("plus.svg").enableStyle(false).rotation(45))
		// .add(new HShape("diamond.svg").enableStyle(false))
		// .add(new HEllipse(30))
		.add ( new HPath().polygon(3) )

		// .layout(
		// 	new HGridLayout()
		// 	.cols(40)
		// 	.spacingX(10)
		// 	.spacingY(10)
		// 	.startX(width/2-200)
		// 	.startY(height/2-200)
		// )

		// .layout(
		// 	new HHexLayout()

		// 	.spacing(15)
		// 	.offsetX(0)
		// 	.offsetY(0)
		// )

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool2.currentIndex();
					HDrawable d = (HDrawable) obj;
					d
						// .enableStyle(false)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.strokeWeight(1.5)
						.stroke(colors2.getColor(),150)
						.noFill()
						// .fill(colors2.getColor(),150)
						// .noStroke()
						.anchorAt(H.CENTER)
						// .rotate( (int)random(4) * 90 )
						.x(random(0,width/2))
						.y(height/2)
						.size((int)random(1,3)*100)
						// .size( ( (int)random(2,6) * 50 ) ) // 50, 100, 150, 200
					;
					// d.randomColors(colors.fillOnly());
					// layout.applyLayout(d);

					new HOscillator()
						.target(d)
						.property(H.SIZE)
						.range(10, 100)
						.speed(.3)
						.freq(random(4))
						// .waveform(H.SAW)
						// .currentStep(i+10)
					;

					// new HOscillator()
					// 	.target(d)
					// 	.property(H.Z)
					// 	.range(-200, 0)
					// 	.speed(.1)
					// 	.freq(4)
					// 	// .waveform(H.SAW)
					// 	// .currentStep(i+120)
					// ;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONY)
						.range(-180, 180)
						.speed(0.05)
						.freq(4)
						// .waveform(H.TRIANGLE)
						// .currentStep(i+100)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONX)
						.range(180, -180)
						.speed(.2)
						.freq(6)
						// .waveform(H.SAW)
						// .currentStep(i)
					;

					// new HOscillator()
					// 	.target(d)
					// 	.property(H.ROTATIONZ)
					// 	.range(-180, 180)
					// 	.speed(0.3)
					// 	.freq(2)
					// 	// .waveform(H.SAW)
					// 	// .currentStep(i)
					// ;

					new HOscillator()
						.target(d)
						.property(H.X)
						.range(random(width/2), width-500)
						.speed(random(0.1,1.5))
						.freq(random(3))
						.waveform(H.SAW)
						// .currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.range(0, height)
						.speed(random(0.1,1))
						.freq(random(4))
						// .waveform(H.SAW)
						.currentStep(i+120)
					;

					
				}
			}
		)
		.requestAll()
	;

	// pool3 = new HDrawablePool(91);
	// pool3.autoAddToStage()
	// 	.add( new HPath() )

	// 	.layout(
	// 		new HHexLayout()
	// 		.spacing(30)
	// 		.offsetX(0)
	// 		.offsetY(0)
	// 	)

	// 	.onCreate (
	// 		new HCallback() {
	// 			public void run(Object obj) {
	// 				int i = pool3.currentIndex();
	// 				HPath d = (HPath) obj;
	// 				d
	// 					.polygon(6)
	// 					.size(210)
	// 					.anchorAt(H.CENTER)
	// 					.stroke(#ffffff)
	// 					.strokeWeight(4)
	// 					.noFill()
	// 				;

	// 				new HOscillator()
	// 					.target(d)
	// 					.property(H.SIZE)
	// 					// .relativeVal(d.y())
	// 					.range(35, 140)
	// 					.speed(2)
	// 					.freq(1.5)
	// 					.currentStep(i)
	// 				;


	// 			}
	// 		}
	// 	)

	// 	.requestAll()
	// ;


	pool4 = new HDrawablePool(91);
	// pool4.autoAddToStage()
	pool4.autoParent(canvas)
		.add( new HPath() )

		.layout(
			new HHexLayout()
			.spacing(45)
			.offsetX(0)
			.offsetY(0)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool4.currentIndex();
					HPath d = (HPath) obj;
					d
						.polygon(6)
						.size(70)
						.anchorAt(H.CENTER)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.strokeWeight(1.5)
						.stroke(colors2.getColor(),150)
						.noFill()
					;

					new HOscillator()
						.target(d)
						.property(H.SIZE)
						// .relativeVal(d.y())
						.range(10, 105)
						.speed(1.5)
						.freq(random(4))

						.currentStep(i)
					;


				}
			}
		)

		.requestAll()
	;



}

 
void draw() {


	// for (HDrawable temp : pool) {
	// 	HDrawable d = (HDrawable) temp;
	// 	pcolors.applyColor(d);
	// }

	H.drawStage();

	if (flipY){
	filter(flipHalfY); //flip half composition with glsl shader
	}
	if (flipX){
	filter(flipHalf); //flip half composition with glsl shader
	}


	// if(frameCount % 1 == 0 && frameCount < 450){
	// 	saveFrame("../frames/image-#####.jpg");
	// }

}


void keyPressed() {


	if (key == ' ') {
		if (paused) {
			loop();
			paused = false;
		} else {
			noLoop();
			paused = true;
		}
	}

	// if (key == '+') {
	// 	drawThings();
	// }

	if (key == 'r') {
		record = true;
		saveFrame("jpg/render_####.jpg");
		// saveVector();
		H.drawStage();
	}

	if (key == CODED) {
		if (keyCode == UP) {
			if(flipY==false){
			flipY=true;
			}
			else{flipY=false;}
		}
		
		if (keyCode == RIGHT) {
			if(flipX==false){
			flipX=true;
			}
			else{flipX=false;}
		}
	}
}


void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "pdf/render_#####.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	}

	endRecord();
}
