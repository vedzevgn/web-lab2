<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Point" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="model.PointsList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>Лабораторная работа #1</title>
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
<div id="modalWindowBack" class="hiddenModalBack">
  <div class="modalWindow closedModalWindow" id="internalErrorWindow">
    <div class="closeButton" onClick="closeModalWindow('internalErrorWindow')"></div>
    <div style="display: flex; flex-direction: row; align-items: center;">
      <p class="subtitle">Внутренняя ошибка</p>
    </div>
    <p class="errorMessage">Произошла ошибка, пожалуйста, повторите попытку.</p>
  </div>
  <div class="modalWindow closedModalWindow" id="incorrectValueWindow">
    <div class="closeButton" onClick="closeModalWindow('incorrectValueWindow')"></div>
    <div style="display: flex; flex-direction: row; align-items: center;">
      <p class="subtitle">Введено некорректное значение</p>
    </div>
    <p class="errorMessage"></p>
  </div>
  <div class="modalWindow closedModalWindow" id="settingsWindow">
    <div class="closeButton" onClick="closeModalWindow('settingsWindow')"></div>
    <div style="display: flex; flex-direction: row; align-items: center;">
      <p class="subtitle">Параметры</p>
    </div>
    <div class="switchRow">
      <label class="switch">
        <input type="checkbox" id="roundXSwitch">
        <span class="slider round"></span>
      </label>
      <p>Притигивать значение X к целому числу</p>
    </div>
    <div class="switchRow">
      <label class="switch">
        <input type="checkbox" id="autoSendSwitch">
        <span class="slider round"></span>
      </label>
      <p>Автоматическая отправка данных точки</p>
    </div>
  </div>
  <div class="modalWindow closedModalWindow" id="areasWindow">
    <div class="closeButton" onClick="closeModalWindow('areasWindow')"></div>
    <div style="display: flex; flex-direction: row; align-items: center;">
      <div class="verticalBox">
        <p class="subtitle">Интерактивная проверка</p>
        <p>Факт попадания точки проверяется по данному графику.</p>
        <div class="imageWrapper" id="coordinates" style="background-image: url(images/areas.png)"></div>
        <p class="hint" id="areasHint" style="margin-top: 10px; margin-bottom: 0px">Выберите на графике точку для проверки</p>
      </div>
    </div>
    <div class="buttonsPanel">
      <div class="button inactiveButton" id="interactiveSubmitButton" onClick="disappear(checkInputs()); closeModalWindow('areasWindow'); setTimeout(() => formSubmit(), 400);">
        <div class="icon" style="background-image: url(icons/arrow.png);"></div>
        <p>Проверить</p>
      </div>
      <div class="modalInput">
        <div class="verticalBox">
        <div class="inputWrapper">
          <input class="textInput" type="text" id="rDublicate" name="r" placeholder="Значение R"
                 oninvalid='showModalWindow("incorrectValue", "Введено некорректное значение R.");'>
        </div>
        </div>
      </div>
    </div>
  </div>
  <div class="modalWindow closedModalWindow" id="clearTableWindow">
    <div class="closeButton" onClick="closeModalWindow('clearTableWindow')"></div>
    <div style="display: flex; flex-direction: row; align-items: center;">
      <p class="subtitle">Очистить результаты?</p>
    </div>
    <p>Вы действительно хотите очистить таблицу с результатами?</p>
    <div class="buttonsPanel">
      <div class="button deleteButton" onclick="clearTable(); closeModalWindow('clearTableWindow');">
        <p>Очистить</p>
      </div>
      <div class="button" id="clearTableWindowButton" onClick="closeModalWindow('clearTableWindow')">
        <p>Отмена</p>
      </div>
    </div>
  </div>
</div>
<div id="header" class="header">
  <div id="logo"></div>
  <div class="headerInfo">
    <a href="https://my.itmo.ru/persons/372796">
      <p>Башаримов Евгений Александрович</p>
    </a>
    <p>P3206</p>
    <p>Вариант #1715</p>
    <div class="icon"  onclick='showModalWindow("settings", "");' style="background-image: url(icons/settings.png); margin-left: 20px; opacity: .8; cursor: pointer;"></div>
  </div>
</div>
<div class="contentWrapper">
  <div id="formWrapper">
    <form method="get" action="${pageContext.request.contextPath}/controller" id="mainForm">
      <div class="centered" style="margin-bottom: 20px;">
        <div class="button" style="margin-right: 20px;" id="areasWindowButton"
             onClick='showModalWindow("areas", "")'>
          <div class="icon" style="background-image: url(icons/areas.png);"></div>
          <p>Интерактивная проверка</p>
        </div>
        <div class="verticalBox">
          <h1 style="margin: 0px;">Проверка точки</h1>
          <p>Введите данные для проверки</p>
        </div>
      </div>
      <div class="verticalBox">
        <p class="label">Координата X</p>
        <p class="label hint">Выберите один из вариантов</p>
      </div>
      <div class="row">
        <div class="slidable" id="buttonsContainer">
          <div class="button"><input type="button" onclick="xUpdate(-3);" value="">
            <p>-3</p>
          </div>
          <div class="button"><input type="button" onclick="xUpdate(-2);" value="">
            <p>-2</p>
          </div>
          <div class="button"><input type="button" onclick="xUpdate(-1);" value="">
            <p>-1</p>
          </div>
          <div class="button"><input type="button" onclick="xUpdate(0);" value="">
            <p>0</p>
          </div>
          <div class="button"><input type="button" onclick="xUpdate(1);" value="">
            <p>1</p>
          </div>
          <div class="button"><input type="button" onclick="xUpdate(2);" value="">
            <p>2</p>
          </div>
          <div class="button"><input type="button" onclick="xUpdate(3);" value="">
            <p>3</p>
          </div>
          <div class="button"><input type="button" onclick="xUpdate(4);" value="">
            <p>4</p>
          </div>
          <div class="button"><input type="button" onclick="xUpdate(5);" value="">
            <p>5</p>
          </div>
          <div class="slidableBoxShadow"></div>
        </div>
        <div class="numberBox" style="margin-right: 20px">
          <p id="xVal">- -</p>
        </div>
      </div>
      <input type="hidden" id="x" name="x" value="">
      <br>
      <div class="verticalBox">
        <p class="label">Координата Y</p>
        <p class="label hint">Введите значение от -3 до 3</p>
      </div>
      <div class="inputWrapper">
        <input class="textInput" type="text" id="y" name="y"
               oninvalid='showModalWindow("incorrectValue", "Введено некорректное значение Y.");'>
      </div>
      <br>
      <div class="verticalBox">
        <p class="label">Значение R</p>
        <p class="label hint">Введите значение от 2 до 5</p>
      </div>
      <div class="inputWrapper">
        <input class="textInput" type="text" id="r" name="r"
               oninvalid='showModalWindow("incorrectValue", "Введено некорректное значение R.");'>
      </div>
      <br>
      <div class="button" onclick="disappear(checkInputs()); setTimeout(() => formSubmit(), 400);">
        <div class="icon" style="background-image: url(icons/arrow.png);"></div>
        <p>Проверить</p>
      </div>
    </form>
  </div>
  <div id="tableBox">
    <h1>Таблица результатов</h1>
    <%
      LinkedList<Map<String, Object>> list = (LinkedList<Map<String, Object>>) application.getAttribute("pointsList");

      if(list == null){
        list = new LinkedList<Map<String, Object>>();
      }

    %>
    <div id="emptyTableMessage">
      <p>Таблица пуста</p>
    </div>
    <div class="tableWrapper">
      <table class="border-none fixedHead" id="resultsTable">
        <thead>
        <tr>
          <th>X</th>
          <th>Y</th>
          <th>R</th>
          <th>Результат</th>
          <th>Выполнение, мс</th>
          <th>Время</th>
        </tr>
        </thead>
        <% for(Map<String, Object> point : list) { %>
        <tr>
          <td><%= point.get("x") %></td>
          <td><%= point.get("y") %></td>
          <td><%= point.get("r") %></td>
          <td><%= (boolean) point.get("result") ? "Попадает" : "Не попадает"%></td>
          <td><%= point.get("calculationTime") %></td>
          <td><%= ((LocalDateTime) point.get("time")).format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss")) %></td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
    <div class="button inactiveButton" id="clearButton" onclick='showModalWindow("clearTable", "")'>
      <div class="icon" style="background-image: url(icons/trash.png);"></div>
      <p>Очистить результаты</p>
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