<%--
  Created by IntelliJ IDEA.
  User: sungbo
  Date: 2016-01-04
  Time: 오전 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>

<script>

  //내 삶을 검증한다.
  function ismylife(mydream){

    var family;
    var friend;
    var soccer;
    var programing;

    mydream = mydream + soccer + programing;

    if(mydream != null){
      //꿈향해 나아간다면
      for(var i=0 ; i < mydream ;i++){
        happiness = family + friend;
        success = true;
      }
    }else{
      //꿈이 없다면... 내 삶은 죽었다.
      return death;
    }
    return live;
  }

</script>

<body>

</body>
</html>
