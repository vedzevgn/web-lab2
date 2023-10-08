<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Результат проверки</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <link type="image/x-icon" href="icons/logo.ico" rel="shortcut icon">
  <link type="Image/x-icon" href="icons/logo.ico" rel="icon">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;700;800&display=swap" rel="stylesheet">
  <link href="style.css" rel="stylesheet">
</head>
<body>
<script>
  window.addEventListener("load", (event) => {
    appear();
  });
</script>
<div id="modalWindowBack" class="hiddenModalBack">
  <div class="modalWindow closedModalWindow" id="internalErrorWindow">
    <div class="closeButton" onClick="closeModalWindow('internalErrorWindow')"></div>
    <div style="display: flex; flex-direction: row; align-items: center;">
      <p class="subtitle">Внутренняя ошибка</p>
    </div>
    <p class="errorMessage">Произошла ошибка, пожалуйста, повторите попытку.</p>
  </div>
</div>
<div id="header" class="header">
  <a href="${pageContext.request.contextPath}"><div id="logo"></div></a>
  <div class="headerInfo">
    <a href="https://my.itmo.ru/persons/372796">
      <p>Башаримов Евгений Александрович</p>
    </a>
    <p>P3206</p>
    <p>Вариант #1715</p>
  </div>
</div>
<div class="contentWrapper" style="opacity: 0;">
  <div id="tableBox">
    <h1>Результат проверки</h1>
    <div class="resultBox validResult">
      <div class="resultBoxShine"></div>
      <div class="icon" style="background-image: url(icons/done.png);"></div>
      <p>Точка попадает в область<p>
    </div>
    <p style="margin-bottom: 10px; margin-top: 20px;">Переданные данные</p>
    <div class="tableWrapper">
      <table class="border-none fixedHead" id="dataTable">
        <thead>
        <tr>
          <th>X</th>
          <th>Y</th>
          <th>R</th>
        </tr>
        </thead>
        <tr>
          <th>1</th>
          <th>2</th>
          <th>3</th>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
  <!--<div class="imageWrapper" style="background-image: url(images/areas.png);"></div>-->
  <div id="timeBox">
    <div class="icon" style="background-image: url(icons/clock.png);"></div>
    <p id="currentTime"></p>
  </div>
</div>
<script src="js/script.js"></script>
</body>
</html>