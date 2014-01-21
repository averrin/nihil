from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
from PyQt5.QtQuick import *
import sys
from time import sleep
from datetime import datetime, timedelta
from frontend import tabs


class App(object):
    def __init__(self):
        self.view = QQuickView()

        self.view.setObjectName("View")
        self.view.setFlags(Qt.FramelessWindowHint)
        self.ctx = self.view.rootContext()
        self.ctx.setContextProperty("viewerWidget", self.view)
        self.ctx.setContextProperty("viewerPosition", self.view.position())
        self.ctx.setContextProperty('TabModel', tabs.tabsList)
        self.view.setSource(QUrl("frontend/qml/nihil.qml"))
        self.view.setResizeMode(QQuickView.SizeRootObjectToView)

        self.Screen = self.view.rootObject()
        self.Titlebar = self.Screen.findChild(QObject, "Titlebar")
        self.Tabs = self.Titlebar.findChild(QObject, "Tabs")
        self.Panel = self.Screen.findChild(QObject, "Panel")

        self.Screen.move.connect(self.moveWindow)
        self.Screen.findChild(QObject, "CloseButton").clicked.connect(exit)
        # self.Screen.findChild(QObject, "MinButton").clicked.connect(self.view.showMinimized)
        self.Screen.findChild(QObject, "MinButton").clicked.connect(self.addTab)
        self.Screen.toggleMax.connect(self.toggleMaxWindow)

        # self.addTab("child")
        self.view.show()

    def addTab(self):
        tabs.tabsList.append(tabs.DataObject("boom", "orange"))

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

sys.exit(app.exec_())
