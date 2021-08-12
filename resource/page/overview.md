# New ANOVA
##  特别说明:本站为[moreThanANOVA](https://hanchen.shinyapps.io/moreThanANOVA/)的汉化版
源码来自[womeimingzi11](https://github.com/womeimingzi11/moreThanANOVA)
使用教程可参见[R Shiny: 使用 moreThanANOVA 进行「正确」的显著性检验](https://blog.washman.top/post/shiny-apps-%E4%BD%BF%E7%94%A8-morethananova-%E8%BF%9B%E8%A1%8C-%E6%AD%A3%E7%A1%AE-%E7%9A%84%E6%98%BE%E8%91%97%E6%80%A7%E6%A3%80%E9%AA%8C.zh-hans/)
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


## 隐私声明
我们保证，你的所有数据将不会被保留。也不会有任何代码来记录你上传的文件或任何其他数据。