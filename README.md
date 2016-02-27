# Installation
Copy the folder 'MDAreaView' to your project,then you can use it.
#Usage
You can find a demo in ViewController.
###Create a MDAreaView
```objectivec
// Init MDAreaView with frame,background image,number of rows and columns.
MDAreaView *areaSelectView = [MDAreaView MDAreaViewWithFram:CGRectMake(20, 60, 300, 400)
                                            backgroundImage:[UIImage imageNamed:@"testPic"]
                                                        row:20
                                                     column:20];
// Set Delegate
areaSelectView.delegate = self;
```
###Delegate
When you change the select view,this delegate will be called.You can get seleted area from areaArray.The array is a Double Dimensional Array(the index are row number and column number) that storage the area`s state,selected(1) or not selected(0).
```objectivec
- (void)MDAreaViewDelegate:(MDAreaView *)mdAreaView areaArray:(NSArray *)array {
    // Do something.
    NSLog(@"Select View:%@", array);
}
```
![Demo](https://github.com/myzlhh/MDAreaView/blob/master/Demo.gif)