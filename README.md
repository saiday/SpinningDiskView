![](https://raw.github.com/saiday/SpinningDiskView/master/docs/SpinningDiskView.gif)

# How to use #

Create SpinningDiskView programmatically or assign SpinningDiskView as your View's custom class.

```objective-c
SpinningDiskView *spinningDiskView =[[SpinningDiskView alloc] initWithFrame:CGRectMake(artWorkX, 0.0, leftSize, leftSize)];
[spinningDiskView setImage:image];
```

That's it. 

### Control the rotation ###

```objective-c
- (void)setRotaion:(BOOL)isRotation;
- (void)toggleRotation;
- (void)startRotation;
- (void)stopRotation;
```

Pick one that suits your requirements.

[WTFPL LICENSE](http://en.wikipedia.org/wiki/WTFPL)
