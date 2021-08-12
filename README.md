# ANOVAshiny
A shinyapp for ANOVA
https://swcyo.shinyapps.io/ANOVA/
###  特别提示:本shiny为[moreThanANOVA的汉化版](https://github.com/womeimingzi11/moreThanANOVA)

## 为什么选择 ANOVA(Analysis of variance,方差分析)
一旦你想比较不同处理之间的一些数据，你从大量论文、文章和论文中学到的是使用**ANOVA（方差分析）**，当然我相信绝大多数的人其实真的不知道什么是 ANOVA。
*问题*：为什么选择ANOVA？以下可能是你想要的答案：

1. 其他人在他们自己的作品中使用它。
2. 它可以比较一些东西。
3. 因为我知道原因。

然而，别人的做法并不总是正确的，不是吗？至少，并不总是适合于任何情况。

## 方差分析之外的事
在这里，我觉得没有必要说明什么是方差分析，关于这个话题自行度娘。

就我所知，方差分析有一个**前提**，事实上它是所有t检验家族的前提，就是**正态分布**（也被称为**高斯分布**）。一旦你的数据不符合正态分布，也许你想对它们进行转换，比如log(x+1)、平方根、对数等等达到正态分布的目的。

然而，我们并不总是幸运狗，从字面上看，在我目前的研究中，它甚至从来就没有对我起过作用。

一般数据呈非正态分布,会选择非参数检验，其中最著名的非参数检验是**Mann–Whitney U检验**， 它用于比较两个处理之间的数据，而在三个或更多的处理之间，经常会用到**Kruskal-Wallis rank sum test**。

这两个检验需要知道什么是signed-rank test(秩检验)和signed-rank sum(秩和检验) test的概念。而我又不是统计学专家,所以也没有必要说明这些概念是什么，但我还是强烈建议你在选择测试之前先度娘一下。这里有一篇由**Stats and R **发布的文章，题为[Wilcoxon test in R: how to compare 2 groups under the non-normality assumption.]（https://www.statsandr.com/blog/wilcoxon-test-in-r-how-to-compare-2-groups-under-the-non-normality-assumption/）。

此外，互换检验(permutation test)也被用来作为评估显著性水平的一种高级方法，特别是对于分布未知的数据。关于更多的信息，有一篇来自[R-Bloger](https://www.r-bloggers.com/what-is-a-permutation-test/)的文章，这里有[另一篇中文文章](https://www.r-bloggers.com/what-is-a-permutation-test/)有做介绍。


## 特征
- [x] 数据视图 [Data View]
- [x] 数据分布检测 [Data Distribution Detect]
  - [x] 数据分布 [Data Distributions]
  - [x] 自动确定方法 [Automatically determine methods]
  - [x] 数据密度图 [Data density plot]
- [x] 显著性比较 [Significant Comparisons]
  - [x] 显著性表格 [Significant Table]
  - [x] 平均值、中位数和显著水平 [Mean, Median and Sig-Level]
  - [x] 事后检验图 [Post Hoc test plot]

## 如何使用它？

### 1. 简单方法
[点击这里](https://hanchen.shinyapps.io/moreThanANOVA/)。moreThanANOVA的主机在[Shinyapps.io](https://Shinyapps.io)。

### 2. 硬核方式
为了确保你能控制一切，我们欢迎你[fork源代码](https://gitee.com/swcyo/moreThanANOVA/fork)到你自己的repo（请给我留个星）。 

### 当然源代码其实在[这里](https://github.com/womeimingzi11/moreThanANOVA)

然后你可以在RStudio中打开`moreThanANOVA.Rproj`文件，接着打开`app.R`文件，安装所有将被加载的包。

最后，点击代码编辑器面板右上方的`run.app`，**rdaWithStep**将在本地运行。



## 隐私声明
我们保证，一旦你离开Shiny应用程序，你的所有数据将不会被保留。没有代码，也不会有任何代码来记录你的cilentID，上传的文件或任何其他数据。

## 联系方式
我的邮箱 [swcyo@126.com](mailto://swcyo@126.com).
