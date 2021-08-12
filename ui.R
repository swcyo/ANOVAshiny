#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# Package to fix error from shinyapps.io
library(markdown)
#
# Package for Shiny
library(shiny)
library(shinythemes)
library(DT)
library(shinydisconnect)

# Package for data manipulation
library(tidyr)
library(dplyr)
library(purrr)
library(readr)
library(stringr)
library(ggplot2)
library(broom)
library(cowplot)

# Package for tests

### Levene’s test
library(car)

### Permutation test
library(coin)

### Multiple Compare
library(rcompanion)
library(multcompView)

### Plot Multiple Compare
library(ggstatsplot)

# Fix font of CJK
library(showtext)

# Define UI for application that draws a histogram
ui <- fluidPage(
  disconnectMessage2(),
  tags$head(tags$style(HTML(
    "
        h3 {
            font-weight:bold
        }
                        "
  ))),
  # Application title
  theme = shinytheme('flatly'),
  # newANOVAtitlePanel("new ANOVA"),
  
  navbarPage(
    "New ANOVA",
    # id = "main_navbar",
    tabPanel(
      '概述',
      fluidRow(column(5,
                      h4(
                        '改编作者:',
                        ' 欧阳松(石河子大学医学院第一附属医院)'
                      )),
               column(3,
                      h5(
                        a(href = "mailto://swcyo@126.com", 'swcyo@126.com')
                      )),
               column(3,
                      h6(
                        'Version: 1.0'
                      ))),
      includeMarkdown('resource/page/overview.md')
    ),
    tabPanel('数据分析',
             sidebarLayout(
               sidebarPanel(
                 img(src = "table_str.png", width = "100%"),
                 h4('数据来源'),
                 radioButtons(
                   'data_source',
                   '上传文件或测试demo',
                   choices = c('上传文件' = 'file',
                               'Iris Data (Demo1)' = 'demo-iris',
                               'ToothGrowth (Demo2)' = 'demo-tooth'),
                   selected = 'demo-tooth'
                 ),
                 conditionalPanel(
                   condition = "input.data_source == 'file'",
                   fileInput('df_upload_file',
                             '请上传你的数据')
                 ),
                 h4('Shapiro-Wilk检验的显著水平'),
                 textInput(
                   'sw_signif_level',
                   'Shapiro-Wilk检验的阈值设定',
                   value = "0.05"
                   ),
                 h4('一个和两个样本测试'),
                 selectInput(
                   "try_paired",
                   "是否需要配对t检验或Wilcoxon符号秩检验?",
                   choices = c(
                     '2-样本/未配对',
                     '1-样本/配对' = 'paired'
                   ),
                   selected = '2-样本/未配对'
                 ),
                 helpText("适用于每组观察次数相同的病例."),
                 h4('组间显著性检验'),
                 selectInput(
                   'is_perm',
                   '是否需要permutation test(置换试验)?',
                   choices = c('否', 
                               'Monte Carlo置换检验' = 'perm'),
                   selected = '否'
                 ),
                 h4('Post-Hoc Test(事后检验)'),
                 selectInput(
                   'p_adjust_method',
                   '多重比较p值的调整方法.',
                   choices = p.adjust.methods,
                   selected = ifelse(
                     length(grep("bonferroni",p.adjust.methods)) == 0, 
                     p.adjust.methods[[1]],
                     "bonferroni")
                   ),
                 helpText(
                   "多重比较p值的调整方法详情",
                   a(href = 'https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/p.adjust',
                     '点击这里.'),
                   'You can also found them from the vignette of',
                   code('stat::p.adjust')
                 )
               ),
               
               # Show a plot of the generated distribution
               mainPanel(tabsetPanel(
                 tabPanel('数据预览',
                          DTOutput("df_com")),
                 tabPanel(
                   '探索性数据分析',
                   h3("分布与方法检测"),
                   DTOutput("df_dist_n_method"),
                   helpText("当P值 < 0.0001时, 显示为 0.0000."),
                   h3('Density Plot(密度图)'),
                   plotOutput("ggplot_hist"),
                   h3('Q-Q Plot(Q-Q图)'),
                   helpText("Q-Q图全称quantile-quantie plot, 即分位数-分位数图,
                            这是一种有点主观的视觉检查.
                            然而,它仍然时有用的工具.
                            在某些情况下, 如果样本量足够大,
                            Shapiro-Wilk Normality test能够检测,
                            即使是对无效假设的细微偏离,
                             (比如, 尽管可能存在一些统计上显著的影响,
                            它可能太小，没有任何实际意义);
                            通常建议通过Q-Q图进行额外调查."),
                   plotOutput("ggplot_qq")
                 ),
                 tabPanel(
                   '比较统计',
                   h3("选择统计方法"),
                   fluidRow(column(width=12,uiOutput("method_determine_select"))),
                   helpText("自动选择统计方法并不总是适用于所有情况.
                            直方图和Q-Q图同样对方法选择有帮助."),
                   h3('组间显著性'),
                   downloadButton('dl_compare_ls',
                                  '下载'),
                   DTOutput('compare_ls'),
                   ########################################
                   # Why don't use the DT tool button?
                   # Becasue the DT solve data table works
                   # on the server rather than local by
                   # default.
                   #
                   # We can use the server = FALSE to load
                   # all the data to local, but once the
                   # data is a super large table, or
                   # your device is not high performance,
                   # it will frozen the browser or cause
                   # some crash.
                   #
                   # So, we seperate the DT and Download
                   # to make things work well.
                   ########################################
                   h3('数据总结'),
                   downloadButton('dl_compare_table',
                                  '下载'),
                   DTOutput('compare_table'),
                   h3('Post-Hoc Test(事后检验)'),
                   fluidRow(
                     column(3,
                            textInput('plot_x_lab',
                                      "自定义X轴标签",
                                      'Treatment')
                     ),
                     column(
                       3,
                       selectInput(
                         'cow_lab',
                         "组合图的标签",
                         choices = c('大写' = "AUTO",
                                     '小写' = "auto"),
                         selected = 'auto'
                       ),
                     )
                   ),
                   fluidRow(
                     column(
                       3,
                       selectInput(
                         'show_statis',
                         '需要显示统计检验吗?',
                         choices = c(
                           '显示' = 'show',
                           '隐藏' = 'hide'
                         ),
                         selected = '显示'
                       )
                     ),
                     column(
                     3,
                     selectInput(
                       'pairwise_display',
                       '选择显示成对比较?',
                       choices = c(
                         '显著' = 'significant',
                         '所有' = 'all',
                         '非显著' = 'non-significant'
                       ),
                       selected = '显著'
                     )
                   ),
                   column(
                     3,
                     selectInput(
                       'pairwise_annotation',
                       '显著性标识注释(目前只能显示P值)',
                       choices = c(
                         'P值' = 'p.value',
                         '星号' = 'asterisk'
                       ),
                       selected = 'asterisk'
                     )
                   )),
                   fluidRow(
                     column(
                       3,
                       numericInput(
                         'figure_ncol',
                         '每行的图片数目 (最大为10)',
                         min = 1,
                         max = 10,
                         value = 3
                       )
                     ),
                     column(
                       3,
                       numericInput(
                         'figure_width',
                         '图片宽度设置 (inch)',
                         min = 3,
                         max = 20,
                         value = 12
                       )
                     ),
                     column(
                       3,
                       numericInput(
                         'figure_height',
                         '图片高度设置 (inch)',
                         min = 3,
                         max = 20,
                         value = 10
                       )
                     )
                   ),
                   p(
                     '当参数设置完成后, 点击',
                     strong('开始作图'),
                     '来绘制图片,或者点击',
                     strong('下载图片'),
                     '来下载图片.'
                   ),
                   helpText(
                     'P.S. 在本页面上显示图形和下载图形采用不同的代码实现，有时候浏览器中显示的图片看起来很杂乱或有线，但通过适当的参数设置，下载的图形仍然可以满足发布级别的标准.'
                   ),
                   actionButton(
                     'plot_figure',
                     label = '开始作图',
                     icon = icon('paint-roller')
                   ),
                   downloadButton('dl_gg', label = '下载图片'),
                   plotOutput('gg_post_hoc', width = 'auto')
                 )
               ))
               
             )),
    tabPanel(
      '致谢和参考文献',
      includeMarkdown('resource/page/acknowledgements.md')
    )
  )
)