package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;

	public class Plane extends MovieClip {
		//DATA MEMBERS
		private var vx: Number; // VELOCITY VECTOR
		private var lastTimeStamp: int; // TIME STAMP

		//--------------------   CONSTRUCTOR   -----------------------------
		public function Plane(side: String, velocity: Number, altitude: Number) {
			// TASK 1: (COMPLETE) ASSIGN PLANE ATTRIBUTES
			//   -REMEMBER THAT FLIGHTS OCCUR FROM LEFT TO RIGHT
			if (side == "left") {
				this.x = -200;
				vx = velocity;
				this.scaleX = -1;
			} else {
				this.x = 1000;
				vx = -velocity;
			}
			
			this.y = altitude;

			// TASK 2: CHOOSE ONE OF THE RANDOM PLANES ON THE TIMELINE
			this.gotoAndStop(Math.floor(Math.random() * 3 + 1));

			// TASK 3: PREPARE FOR ANIMATION BY REGISTERING AN ENTER_FRAME EVENT
			// AND INITIALIZING THE TIME STAMP.
			addEventListener(Event.ENTER_FRAME, movePlane);
			lastTimeStamp = getTimer();
		}

		//----------------------------------------------------------------
		public function movePlane(event: Event) {
			// TASK 1: (COMPLETE) USE TIME-BASED ANIMATION TO MOVE THE PLANE
			var elapsedTime: int = getTimer() - lastTimeStamp;
			lastTimeStamp += elapsedTime;
			this.x += vx * elapsedTime / 1000;

			// TASK 2: DELETE IF  PLANE HAS LEFT THE BOUNDARIES OF THE STAGE
			if ((vx < 0) && (x < -150)) {
				deletePlane();
			} else if ((vx > 0) && (x > 1000)) {
				deletePlane();
			}
		}

		//----------------------------------------------------------------
		public function explodePlane() {
			removeEventListener(Event.ENTER_FRAME, movePlane);
			MovieClip(parent).removePlane(this);
			//GO TO THE FRAME CONTAINING THE LABEL EXPLODE
			gotoAndPlay("explode"); //FRAME-BY-FRAME ANIMATION
		}

		//----------------------------------------------------------------
		public function deletePlane() {
			//DELETE PLANE FROM THE STAGE AND REMOVE THE EVENT LISTENER
			removeEventListener(Event.ENTER_FRAME, movePlane);
			MovieClip(parent).removePlane(this);
			parent.removeChild(this);
		}
	}
}