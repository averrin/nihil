from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
from PyQt5.QtQuick import *
import sys
from time import sleep
from datetime import datetime, timedelta


class App(object):
    def __init__(self):
        self.view = QQuickView()


        self.view.setObjectName("View")
        self.view.setFlags(Qt.FramelessWindowHint)
        self.view.rootContext().setContextProperty("viewerWidget", self.view)
        self.view.rootContext().setContextProperty("viewerPosition", self.view.position())
        self.view.setSource(QUrl("nihil.qml"))
        self.view.setResizeMode(QQuickView.SizeRootObjectToView)

        self.Screen = self.view.rootObject()
        self.Titlebar = self.Screen.findChild(QObject, "Titlebar")
        self.Panel = self.Screen.findChild(QObject, "Panel")

        self.Screen.move.connect(self.moveWindow)
        self.Screen.findChild(QObject, "CloseButton").clicked.connect(exit)
        self.Screen.findChild(QObject, "MinButton").clicked.connect(self.view.showMinimized)
        self.Screen.toggleMax.connect(self.toggleMaxWindow)

        self.view.show()

    def moveWindow(self, dx, dy):
        if self.view.windowState() == Qt.WindowMaximized:
            self.view.showNormal()
        j = 16
        if abs(dx) > j:
            dx = j * (dx/abs(dx))
        if abs(dy) > j:
            dy = j * (dy/abs(dy))

        y = self.view.position().y() + dy
        x = self.view.position().x() + dx
        # if y <= 24:
        #     self.view.showMaximized()
        # else:
        #     self.view.showNormal()
        #     pass
        self.view.setWidth(800)
        self.view.setHeight(600)
        self.view.setPosition(QPoint(x, y))
        self.view.rootContext().setContextProperty("viewerPosition", self.view.position())
        # sleep(0.1)

    def toggleMaxWindow(self):
        if self.view.windowState() == Qt.WindowMaximized:
            self.view.showNormal()
        else:
            self.view.showMaximized()

app = QApplication(sys.argv)
nihil = App()

app.exec_()
