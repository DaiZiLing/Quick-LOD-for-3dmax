# Quick-LOD-for-3dmax

![image](https://github.com/DaiZiLing/Quick-LOD-for-3dmax/blob/main/0317_1.gif)

之前做场景时用的，虽然我这边的策划不要求做LOD（他们连LOD是什么都不知道），但我还是强迫症给它做了

手动把模型复制3份出来，调整优化参数太慢了，最后还得对齐成组。

于是做了这么一个脚本，没什么卯月，因为UE4什么的几乎都带有他们自己的AutoLOD。

而且这脚本也不是那么“Quick”，还是得肉眼观察差异。

另外，我也不会减面算法，使用的是3dsmax自带的 “ProOptimize”

食用方法：选择你要做LOD的模型（记得先塌陷为polygon）、孤立物体；点击复制；点击重命名；点击优化；点击对齐，完成。

默认的优化参数是100% → 50% → 25% → 13%

A small toy for 3dsmax, to creat LOD for appilication such as Unity / Unreal as so on.

Select the model, collapse it to EditPoly, then press Alt + Q.

Run the script , click "Copy", click "Rename", click "Optimize", Click "Align".

Finally get a LOD group of a stone in GIF, default value of optimize is 100% → 50% → 25% → 13%

(May get wrong Encoding Error in NOT Simple-Chinese 3dsmax, you probroly need to open my script to modify ALL Hanzi to whatever you like.
