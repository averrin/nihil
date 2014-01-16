from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
from PyQt5.QtQuick import *
import sys
from time import sleep
from datetime import datetime, timedelta

app = QApplication(sys.argv)

view = QQuickView()
view.setObjectName("View")
view.setFlags(Qt.FramelessWindowHint)
view.rootContext().setContextProperty("viewerWidget", view)
print(view.position())
view.rootContext().setContextProperty("viewerPosition", view.position())
view.setSource(QUrl("example.qml"))
view.setResizeMode(QQuickView.SizeRootObjectToView)
# item = view.rootObject().children()[1].findChild(QObject, "testText")
# print(dir(view))
# print(item)
# Window = view.rootObject()
Screen = view.rootObject()
Titlebar = Screen.findChild(QObject, "Titlebar")
Panel = Screen.findChild(QObject, "Panel")
# print(dir(Titlebar))
# Titlebar.clicked.connect(exit)
lt = datetime.now()


def moveWindow(dx, dy):
    j = 16
    if abs(dx) > j:
        dx = j * (dx/abs(dx))
    if abs(dy) > j:
        dy = j * (dy/abs(dy))

    y = view.position().y() + dy
    x = view.position().x() + dx
    if y <= 24:
        view.showMaximized()
    else:
        view.showNormal()
        pass
    view.setPosition(QPoint(x, y))
    view.rootContext().setContextProperty("viewerPosition", view.position())
    # sleep(0.1)


def toggleMaxWindow():
    if view.windowState() == Qt.WindowMaximized:
        view.showNormal()
    else:
        view.showMaximized()


# print(view.setFlags(Qt.Window))

Screen.move.connect(moveWindow)
Screen.close.connect(exit)
Screen.toggleMax.connect(toggleMaxWindow)

t = Panel.findChild(QObject, "testText")
t.setProperty("text", "ololo")
# print(view.rootObject().children()[0].objectName())
view.show()
# view.showMaximized()
app.exec_()
