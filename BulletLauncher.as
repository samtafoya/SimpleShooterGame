package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;

	public class BulletLauncher extends MovieClip {
		//DATA MEMBERS (COMPLETE)
		static const vx: Number = 150.0; // VELOCITY IS ALONG THE X AXIS
		private var lastTimeStamp: int; // LAST TIME STAMP

		//----------------------    CONSTRUCTOR      ---------------------
		public function BulletLauncher() {

			this.x = 450;
			this.y = 450;
			lastTimeStamp = getTimer();

			// REGISTER A LISTENER EVENT TO CONTROL MOVEMENT AFTER EACH ENTER_FRAME
			addEventListener(Event.ENTER_FRAME, moveBulletLauncher);
		}

		/*public function moveLeft() {
			this.x -= vx;
			if (this.x < 100) {
				this.x = 100;
			}

		}

		public function moveRight() {
			this.x += vx;
			if (this.x > 900) {
				this.x = 900;
			}
		}*/

		//----------------------------------------------------------------
		public function moveBulletLauncher(event:Event) {
          // TASK 1: (COMPLETE) USE TIME-BASED ANIMATION TO MOVE THE BULLETLAUNCHER
			var elapsedTime: int = getTimer() - lastTimeStamp;	
			lastTimeStamp += elapsedTime;
			if (MovieClip(parent).leftArrow) {
				this.x -= vx * elapsedTime / 1000;
			}
			if (MovieClip(parent).rightArrow) {
				this.x += vx * elapsedTime / 1000;
			}


          // TASK 2: (COMPLETE) ERROR DETECTION: MAKE SURE IT DOES NOT MOVE OFF SCREEN
			if (this.x < 100) {
				this.x = 100;
			}
			if (this.x > 900) {
				this.x = 900;
			}






        }
	}
}