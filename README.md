# FrameworksWorkshop

This Xcode workspace serves as a development and testing host for some useful frameworks that I carry around between iOS projects. Currently it has three frameworks: PDLUIToolBox, PDLTestBench, and PDLToolBox.

- __PDLUIToolBox__ defines various UI tools that are useful from time to time, e.g., a replacement for the deprecated UIAlert behavior, finding the front view controller, and traversing a view hierarchy with an action handler.
- __PDLTestBench__ defines "player" and "recorder" classes that enable one, respectively, to define expected events and behaviors for mock classes, and to capture actual events and behaviors for mock and spy classes.
- __PDLToolBox__ defines some basic data structure classes that are used by PDLTestBench.
