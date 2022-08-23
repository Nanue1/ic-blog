
# ic-blog
serve.sh 
    本地开发

build.sh
    部署到 ic 网络

## theme 适配 ic

1. 保留原始模版，用于本地开发 
   cp  -r themes/archie-zola/templates  .
   ./serve.sh

2. theme 渲染出的文章路径中，默认添加 index.html

