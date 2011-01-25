package 
{
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import com.bit101.components.VBox;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * Small program that calculates how much me and my girlfriend should pay each month
	 * given how much money we earn.
	 * 
	 * Only reason I did it in flash is because it's the fastest way for me get it done.
	 * Would probably have been more efficient (and transparent) to write it in javascript.
	 * That is why I open source it =)
	 * 
	 * @author Tommislav, tommy@salomonsson.se
	 */
	public class Main extends Sprite 
	{
		private var _inputA:InputText;
		private var _inputB:InputText;
		private var _inputCost:InputText;
		
		private var _result:Text;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var vBox:VBox = new VBox( this, 10, 10 );
			vBox.addChild( new Label( this, 0, 0, "Income person A:" ) );
			
			_inputA = new InputText( this );
			vBox.addChild( _inputA );
			
			vBox.addChild( new Label( this, 0, 0, "Income person B:" ) );
			
			_inputB = new InputText( this );
			vBox.addChild( _inputB );
			
			vBox.addChild( new Label( this, 0, 0, "Sum costs:" ) );
			_inputCost = new InputText( this );
			vBox.addChild( _inputCost );
			
			vBox.addChild( new PushButton( this, 0, 0, "Done", doCalc ) );
			
			_result = new Text( this, 10, 180 );
			
			var info:Label = new Label( this, 170, 10, "Calculate how much you and your partner should\npay each month split on the same ratio as your\ndifference in income" );
			
			stage.focus = _inputA.textField;
		}
		
		private function doCalc(e:Event):void
		{
			var a:Number = Number( _inputA.text );
			var b:Number = Number( _inputB.text );
			var tot:Number = a + b;
			var cost:Number = Number( _inputCost.text );
			
			var aRatio:Number = a / tot;
			var bRatio:Number = b / tot;
			
			var aPay:Number = cost * aRatio;
			var bPay:Number = cost * bRatio;
			
			var str:String = ""
			str += "Person A should pay: " + roundToTwoDecimals(aPay) + "\n";
			str += "Person B should pay: " + roundToTwoDecimals(bPay) + "\n";
			str += "Person A and B pays together: " + roundToTwoDecimals(aPay + bPay) + "\n";
			str += "Income A+B: " + roundToTwoDecimals(a + b) + "\n";
			str += "Ratios A: " + roundToTwoDecimals(aRatio*100) + "%, B:" + roundToTwoDecimals(bRatio * 100) + "%";
			
			_result.text = str;
		}
		
		private function roundToTwoDecimals( n:Number ):Number
		{
			return Math.round( n * 100 ) / 100;
		}
	}
	
}