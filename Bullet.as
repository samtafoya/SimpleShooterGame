package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;

	public class Bullet extends MovieClip {
		//DATA MEMBERS (COMPLETE)

		private var vy: Number; // VELOCITY VECTOR
		private var lastTimeStamp: int; // TIME STAMP

		//------------------------ CONSTRUCTOR ----------------------------
		public function Bullet(startX: Number, startY: Number, velocity: Number) {
			// TASK 1: (COMPLETE) SET THE START POSITION OF THE BULLET AND VELOCITY
			vy = velocity; 
			this.x = startX;
			this.y = startY;

			// TASK 2: (COMPLETE) GET THE TIME STAMP FOR TIME-BASED ANIMATION
			lastTimeStamp = getTimer();

			// TASK 3: REGISTER A LISTENER EVENT TO MOVE THE BULLET
			addEventListener(Event.ENTER_FRAME, moveBullet);
		}

		//----------------------------------------------------------------
		public function moveBullet(event: Event) {
			// TASK 1: (COMPLETE) USE TIME-BASED ANIMATION TO MOVE THE BULLET
			var elapsedTime: int = getTimer() - lastTimeStamp;
			lastTimeStamp += elapsedTime;
			this.y += vy * elapsedTime / 1000;

			// TASK 2: DELETE BULLET ONCE IT MOVES OFF THE SCREEN
			if (this.y < 0) {
				deleteBullet();
			}
		}

		//----------------------------------------------------------------
		// DELETE BULLET FROM STAGE AND ELIMINATE THE EVENT HANDLER
		public function deleteBullet() {
			MovieClip(parent).removeBullet(this);
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, moveBullet);
		}
	}
}