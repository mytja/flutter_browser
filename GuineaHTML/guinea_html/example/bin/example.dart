import 'package:guinea_html/guinea_html.dart';

void main(List<String> arguments) async {
  await initializeLibrary();
  const String css = """
    html{
      font-family:'Segoe UI', Arial, sans-serif
    }
    body{
      height:100%
    }
    .header{
      font-size:32px;
      font-weight:bold;
      color:#dc5e47
    }
    #lite_wrapper{
      position:relative;
      top:25%
    }
    .query{
      border-color:#dc5e47;
      border-style:solid solid solid solid;
      border-width:1px 1px 1px 1px;
      -moz-border-radius:3px;
      border-radius:3px;
      font-size:20px;
      padding:5px 6px;
      text-align:left;
      width:60%;
      max-width:600px;
      height:28px
    }
    .submit{
      height:40px;
      font-size:20px;
      cursor:pointer
    }
    .html-only{
      font-size:12px
    }
    a{
      text-decoration:none;
      color:#1168CC
    }
    a:hover{
      text-decoration:underline
    }
    a:visited{
      color:#6830BB
    }
    @media only screen and (max-device-width: 700px){
      body{
        width:100%;
        margin-left:2px;
        padding:0
      }
      .query{
        width:160px
      }
    }
    @media only screen and (max-device-width: 701px) and (orientation: landscape){
      .query{
        width:253px
      }
    }
    """;
  print(parseCSS(css));
}
