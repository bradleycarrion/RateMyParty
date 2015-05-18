//imports


/** 
  * Description of what the class does
  */

  //Class names should describe what the class is
  // e.g. if the class is a view controller it should end with viewcontroller
  // TestViewController.swift

class Example : SomeBaseClass {
      
    //one liner to describe the property
    //related members do not skip a line

    //constants
    let SOME_CONSTANT: Double = 3.14159

    //properties from storyboard
    @IBOutlet var someTableView:UITableView?
    @IBOutlet var fooLabel: UILabel?

    //then come other members labled with propper access control
    private var theCount: Int


    //constructors <one liner to describe purpose>
    override init() {
        super.init()
    }

      /** 
        *  Now come class methods with param, return description
        */      
    class func someStaticMethod() {
	      //do stuff
	}
      

    /**
      * regular overriden methods (do not require method description)
	  */
	override func someBaseClassMethod() {

	}

	/**
	  * regular instance methods
    */
	func someInstanceMethod() {
	     //do stuff
	}

	/**
	  *	delegate methods
	  */

    func someDelegateMethod() {
	  
    }

}
//end class