package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	public class SimpleShooter extends MovieClip {
		//DATA MEMBERS
		private var bulletLauncher: BulletLauncher;
		private var planes: Array;
		private var bullets: Array;
		public var leftArrow, rightArrow: Boolean;
		
		private var lastTimeStamp: int; // TIME STAMP

		private var nextPlane: Timer; //USED TO SCHEDULE ADDITIONAL PLANES

		//------------------ DOCUMENT CLASS CONSTRUCTOR ------------------
		//DOCUMENT CLASS CONSTRUCTOR
		public function SimpleShooter() {
			// TASK 1: (COMPLETE) CREATE A BULLET LAUNCHER AND ADD IT TO THE STAGE

			bulletLauncher = new BulletLauncher();
			addChild(bulletLauncher);


			// TASK 2: (COMPLETE) CREATE THE ARRAYS TO HOLD PLANES AND BULLETS.
			planes = new Array();

			bullets = new Array();
			
			//lastTimeStamp =  getTimer();


			// TASK 3: REGISTER KEYBOARD EVENTS FOR KEY UP AND KEY DOWN
			//   - FIRING BULLETS AND MOVING THE BULLET LAUNCHER
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownFunction);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpFunction);

			// TASK 4: UPDATE SCREEN
			//    -CHECK FOR COLLISIONS: PLANES HIT BY BULLETS
			//    -MAKE SURE THE BULLET LAUNCHER HAS COOLED DOWN BEFORE FIRING ANOTHER BULLET
			addEventListener(Event.ENTER_FRAME, updateGame);

			// TASK 5: SCHEDULE PLANES TO APPEAR AT INTERVALS
			scheduleNextPlane();
		}

		//----------------------------------------------------------------
		public function scheduleNextPlane() {
			nextPlane = new Timer(500 + Math.random() * 500, 1);
			nextPlane.addEventListener(TimerEvent.TIMER_COMPLETE, createPlane);
			nextPlane.start();
		}

		//----------------------------------------------------------------
		public function createPlane(event: TimerEvent) {
			// TASK 1: (COMPLETE) SET PLANE ATTRIBUES, ADD A NEW PLANE TO THE STAGE AND ARRAY
			// -PLANES WILL APPEAR AT DIFFERENT SIDES OF THE STAGE
			// -PLANES WILL BE ASSIGNED A RANDOM VELOCITY AND ALTITUDE

			var whichSide: String = "left";
			if (Math.random() > .5) {
				whichSide = "right";
			}
			var velocity: Number = Math.random() * 300 + 100;
			var altitude: Number = Math.random() * 250 + 100;

			var p: Plane = new Plane(whichSide, velocity, altitude);
			addChild(p);
			planes.push(p);

			// TASK 2: SCHEDULE THE NEXT PLANE TO APPEAR
			scheduleNextPlane();
		}

		//------------- UPDATE GAME:  COLLISION DETECTION -----------------
		public function updateGame(event: Event) {

			//SEARCH THE ARRAYS FROM BACK TO FRONT
			for (var iBullet: int = bullets.length - 1; iBullet >= 0; iBullet--) {
				for (var iPlane: int = planes.length - 1; iPlane >= 0; iPlane--) {

					//BULLET AND PLANE COLLIDE
					if (bullets[iBullet].hitTestObject(planes[iPlane])) {
						//DELETE BOTH THE BULLET AND PLANE FROM THE GAME
						planes[iPlane].explodePlane();
						bullets[iBullet].deleteBullet();
						break;
					}
				}
			}
		}

		//------------------- KEYBOARD EVENT METHODS--------------------
		public function keyDownFunction(event: KeyboardEvent) {
			
			if (event.keyCode == 37) {
				leftArrow = true;
				//bulletLauncher.moveLeft();
			} else if (event.keyCode == 39) {
				rightArrow = true;
				//bulletLauncher.moveRight();
			} //else if (event.keyCode == 32) {
				//fireBullet();
			//}
		}

		public function keyUpFunction(event: KeyboardEvent) {
			if (event.keyCode == 37) {
				leftArrow = false;
				//bulletLauncher.moveLeft();
			} else if (event.keyCode == 39) {
				rightArrow = false;
				//bulletLauncher.moveRight();
			} else if (event.keyCode == 32) {
				lastTimeStamp = getTimer();
				var elapsedTime: int = 0;
				elapsedTime = getTimer() - lastTimeStamp;
				lastTimeStamp += elapsedTime;				
				if (lastTimeStamp / 1000 > 3) {
					fireBullet();
					elapsedTime = 0;
				}
			}
		}

		
		
		//------------------------ FIRING A BULLET ---------------------------
		public function fireBullet() {
			//GENERATE A NEW BULLET AND ADD IT TO THE ARRAY
			var bullet: Bullet = new Bullet(bulletLauncher.x, bulletLauncher.y, -300);
			addChild(bullet);
			bullets.push(bullet);
				
		}

		//-------------- REMOVING A DOWNED PLANE AND BULLET ------------------
		public function removePlane(plane: Plane) {
			// SEARCH FOR THE PLANE AND REMOVE IT FROM THE ARRAY: USE SPLICE
			for (var i in planes) {
				if (planes[i] == plane) {
					planes.splice(i, 1);
					break;
				}
			}
		}

		public function removeBullet(bullet: Bullet) {
			// SEARCH FOR THE BULLET AND REMOVE IT FROM THE ARRAY: USE SPLICE
			for (var i in bullets) {
				if (bullets[i] == bullet) {
					bullets.splice(i, 1);
					break;
				}
			}
		}
	}
}