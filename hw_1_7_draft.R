library(help = 'datasets')

data(swiss)
class(swiss)
dim(swiss)
str(swiss)
summary(swiss)

if(!require(pander)) install.packages('pander')

if (!require(pander)) {
  if (!require(devtools)) {
    install.packages('devtools', repos = 'https://cloud.r-project.org') 
  }
  devtools::install_github('Rapporter/pander')
}

pander::pandoc.table(head(swiss,15))

help(pairs)

# Функция для добавления гистограмм на диаграмму корреляционной матрицы
# Можно найти в справке для функции pairs()
panel.hist <- function(x, ...) 
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}

# Функция для отображения коэффициента корреляции на диаграмме коррел. матрицы
panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}
pairs(swiss, upper.panel=panel.cor, diag.panel=panel.hist)

fit <- kmeans(swiss, 2)
plot.kmeans(fit, data = swiss)

pairs(swiss, col = fit$cluster)
