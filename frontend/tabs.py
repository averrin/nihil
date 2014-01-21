from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
from PyQt5.QtQuick import *


class DataObject(QObject):

    nameChanged = pyqtSignal()

    @pyqtProperty(str, notify=nameChanged)
    def name(self):
        return self._name

    @name.setter
    def name(self, name):
        if self._name != name:
            self._name = name
            self.nameChanged.emit()

    colorChanged = pyqtSignal()

    @pyqtProperty(str, notify=colorChanged)
    def color(self):
        return self._color

    @color.setter
    def color(self, color):
        if self._color != color:
            self._color = color
            self.colorChanged.emit()

    def __init__(self, name='', color='', parent=None):
        super(DataObject, self).__init__(parent)

        self._name = name
        self._color = color


tabsList = [DataObject("Item 1", 'red'),
                DataObject("Item 2", 'green'),
                DataObject("Item 3", 'blue'),
                DataObject("Item 4", 'yellow')]