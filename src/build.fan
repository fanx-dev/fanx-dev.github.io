
using fandoc

class Main {
    Str outDir = "../doc/"

    Void main() {
        dir := File(`./`)
        dir.list.each |f| {
            if (f.ext == "fandoc")
            write(f)
        }
    }

    private Void write(File file) {
        text := file.readAllStr
        // parse into document tree
        doc := FandocParser.make.parseStr(text)

        outFile := File(Uri(outDir + file.basename + ".html"))
        out := outFile.out
        writeStart(out)
        doc.writeChildren(HtmlDocWriter.make(out))
        writeEnd(out)
        out.close
    }

    private Void writeStart(OutStream out) {
        out.writeChars(
        """

            <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
             "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
            <html xmlns='http://www.w3.org/1999/xhtml'>
            <head>
              <title>Fanx</title>
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
              <link rel="stylesheet" type="text/css" href="../common.css"/>
              <link rel="stylesheet" type="text/css" href="style.css"/>
              <style type="text/css">
              #content .item { 
                font-size:130%;
                padding:10px;
              }
              #content h2 {
                margin-top: 50px;
              }

              </style>
            </head>
            <body>
              <div id="header">
                <div class="sitebar">
                  <ul>
                    <li>
                      <a href='../index_zh.html'>首页</a>
                    </li>

                    <li>
                      <a href='../download.html'>下载</a>
                    </li>

                    <li>
                      <a href='../document.html'>文档</a>
                    </li>

                    <li>
                      <a href='../community_zh.html'>交流社区</a>
                    </li>
                 </ul>
                </div>

              </div>

              <div class="content">
              """)
    }

    private Void writeEnd(OutStream out) {
        out.writeChars(
            """
                  </div>
                </body>
                </html>
                """)
    }
}