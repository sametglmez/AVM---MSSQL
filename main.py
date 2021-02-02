import pyodbc
from PyQt5 import QtWidgets, uic
from PyQt5.QtCore import QTimer
from PyQt5.QtWidgets import QApplication, QWidget, QPushButton
import sys

from PyQt5.uic.properties import QtCore


class Ui(QtWidgets.QMainWindow):
    def __init__(self):
        super(Ui, self).__init__()

        self.server = 'DESKTOP-75I874K'
        self.database = 'AVM'
        self.username = 'samet'
        self.password = '12345'
        self.db = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};SERVER=' + self.server + ';DATABASE=' + self.database + ';UID=' + self.username + ';PWD=' + self.password)


        uic.loadUi("C:\\Users\\samet\\Desktop\\denemeqt.ui", self)
        self.show()

    def calisan(self):
        cursor = self.db.cursor()
        query = "SELECT * FROM CINSIYETSAYISI;"
        cursor.execute(query)
        recors = cursor.fetchall()

        table_row = len(recors)
        self.table.setRowCount(table_row)

        table_column = len(recors[0])
        self.table.setColumnCount(table_column)

        self.table.setHorizontalHeaderLabels(
            ['AVM_ISIM', 'SEMT_ISIM', 'CINSIYET', 'CALISANSAYISI'])

        for i in range(table_row):
            for j in range(table_column):
                self.table.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))

        QTimer.singleShot(10000, self.calisan)

    def kazanc(self):
        query = "SELECT * FROM KAZANC;"
        cursor = self.db.cursor()
        cursor.execute(query)
        recors = cursor.fetchall()

        table_row = len(recors)
        self.kazanctable.setRowCount(table_row)

        table_column = len(recors[0])
        self.kazanctable.setColumnCount(table_column)

        self.kazanctable.setHorizontalHeaderLabels(
            ['AVM_ISIM', 'MAGAZA_ISIM', 'SEMT_ISIM', 'TOPLAM_KAZANC'])

        for i in range(table_row):
            for j in range(table_column):
                self.kazanctable.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))

        QTimer.singleShot(1000, self.kazanc)


    def ortalamayas(self):
        query = "SELECT * FROM ORTALAMAYAS;"
        cursor = self.db.cursor()
        cursor.execute(query)
        recors = cursor.fetchall()

        table_row = len(recors)
        self.ortalamatable.setRowCount(table_row)

        table_column = len(recors[0])
        self.ortalamatable.setColumnCount(table_column)

        self.ortalamatable.setHorizontalHeaderLabels(
            ['SEMT_ISIM', 'AVM_ISIM', 'AVM_ID', 'ORTALAMA_YAS'])

        for i in range(table_row):
            for j in range(table_column):
                self.ortalamatable.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))

        QTimer.singleShot(1000, self.ortalamayas)

    def sektor(self):
        query = "SELECT * FROM SEKTORMAGAZA;"
        cursor = self.db.cursor()
        cursor.execute(query)
        recors = cursor.fetchall()

        table_row = len(recors)
        self.sektortable.setRowCount(table_row)

        table_column = len(recors[0])
        self.sektortable.setColumnCount(table_column)

        self.sektortable.setHorizontalHeaderLabels(
            ['AVM_ISIM', 'SEKTOR_ISIM', 'MAGAZA_ISIM', 'SEMT_ISIM'])

        for i in range(table_row):
            for j in range(table_column):
                self.sektortable.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))

        QTimer.singleShot(1000, self.sektor)


    def urunstok(self):
        query = "SELECT * FROM URUNSTOGU;"
        cursor = self.db.cursor()
        cursor.execute(query)
        recors = cursor.fetchall()

        table_row = len(recors)
        self.stoktable.setRowCount(table_row)

        table_column = len(recors[0])
        self.stoktable.setColumnCount(table_column)

        self.stoktable.setHorizontalHeaderLabels(
            ['SEMT_ISIM', 'AVM_ISIM', 'MAGAZA_ISIM', 'URUN_TIP', 'STOK_ADET'])

        for i in range(table_row):
            for j in range(table_column):
                self.stoktable.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))

        QTimer.singleShot(1000, self.urunstok)


    def semtsilinemez(self):
        query = "SELECT * FROM SEMT;"
        cursor = self.db.cursor()
        cursor.execute(query)
        recors = cursor.fetchall()

        table_row = len(recors)
        self.semttable.setRowCount(table_row)

        table_column = len(recors[0])
        self.semttable.setColumnCount(table_column)

        self.semttable.setHorizontalHeaderLabels(
            ['SEMT_ID', 'SEMT_ISIM', 'LOKASYON', 'NUFUS'])

        for i in range(table_row):
            for j in range(table_column):
                self.semttable.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))





    def insert2(self):
        print("semt için girdiii")
        semtidd = int(self.lineid.text())
        semtisimm = self.lineisim.text()
        lokasyonn = self.linelokasyon.text()
        nufus = int(self.linenufus.text())
        print(semtisimm)
        print(lokasyonn)
        print(nufus)

        result = self.db.cursor()

        result.execute("INSERT INTO SEMT(semtid, semtisim, lokasyon, nufus) VALUES  (?,?,?,?)",
                       (semtidd, semtisimm, lokasyonn, nufus))

        try :
            result.fetchall()
        except:
            self.semtsonuc.setText("SEMT EKLENEMEZ")
            print("SEMT EKLENEMEZ")

        self.db.commit()



    def fiyatkontrol2(self):
        query = "SELECT * FROM URUN;"
        cursor = self.db.cursor()
        cursor.execute(query)
        recors = cursor.fetchall()


        table_row = len(recors)
        self.uruntable.setRowCount(table_row)

        table_column = len(recors[0])
        self.uruntable.setColumnCount(table_column)

        self.uruntable.setHorizontalHeaderLabels(
            ['URUN_ID', 'FIYAT', 'URUN_TIP', 'MAGAZA_ID', 'SATIS_ADET', 'STOK_ADET'])

        for i in range(table_row):
            for j in range(table_column):
                self.uruntable.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))

        QTimer.singleShot(1000, self.fiyatkontrol2)


    def inserturunfun(self):
        urunidd = int(self.lineidurun.text())
        urunfiyat = float(self.linefiyaturun.text())
        uruntip = self.linetipurun.text()
        magazaidd = int(self.linemagazaurun.text())
        urunsatisadet = int(self.linesatsurun.text())
        urunstokadet = int(self.linestokurun.text())

        result1 = self.db.cursor()

        result1.execute("INSERT INTO URUN(urunid, fiyat, uruntip, magazaid,satisadet,stokadet) VALUES  (?,?,?,?,?,?)",
                        (urunidd, urunfiyat, uruntip, magazaidd, urunsatisadet, urunstokadet))

        try:
            result1.fetchall()
        except:
            if(urunfiyat > 10):
                self.semtsonuc_2.setText("Başarılı şekilde eklendi !!!")
            else:
                self.semtsonuc_2.setText("10 Liradan küçük giyim ürünü eklenemez !!!")
            #print("10 Liradan küçük giyim ürünü eklenemez !!!")

        self.db.commit()


    def stokkontrol(self):
        query = "SELECT * FROM URUNSATIS;"
        cursor = self.db.cursor()
        cursor.execute(query)
        recors = cursor.fetchall()

        table_row = len(recors)
        self.stoktable_3.setRowCount(table_row)

        table_column = len(recors[0])
        self.stoktable_3.setColumnCount(table_column)

        self.stoktable_3.setHorizontalHeaderLabels(
            ['SATIS_ID', 'URUN_ID', 'MAGAZA_ID'])

        for i in range(table_row):
            for j in range(table_column):
                self.stoktable_3.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))

        query = "SELECT * FROM URUN;"
        cursor = self.db.cursor()
        cursor.execute(query)
        recors = cursor.fetchall()

        table_row = len(recors)
        self.stok_table4.setRowCount(table_row)

        table_column = len(recors[0])
        self.stok_table4.setColumnCount(table_column)

        self.stok_table4.setHorizontalHeaderLabels(
            ['URUN_ID', 'FIYAT', 'URUN_TIP', 'MAGAZA_ID', 'SATIS_ADET', 'STOK_ADET'])

        for i in range(table_row):
            for j in range(table_column):
                self.stok_table4.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))

        QTimer.singleShot(1000, self.stokkontrol)

    def insertsatis(self):
        print("girdiiii--------------")
        satisid = int(self.linestokid.text())
        satisurunid = float(self.linestokurunid.text())
        satismagazaid = self.linestokmagazaid.text()


        result1 = self.db.cursor()

        result1.execute("INSERT INTO URUNSATIS (satisid, urunid, magazaid) VALUES  (?,?,?)",
                        (satisid, satisurunid, satismagazaid))

        try:
            result1.fetchall()
        except:
            self.semtsonuc_3.setText("Değiştirildi!!!")

        self.db.commit()


    def musterikontrol(self):
        query = "SELECT * FROM MUSTERI;"
        cursor = self.db.cursor()
        cursor.execute(query)
        recors = cursor.fetchall()

        table_row = len(recors)
        self.musteritable.setRowCount(table_row)

        table_column = len(recors[0])
        self.musteritable.setColumnCount(table_column)

        self.musteritable.setHorizontalHeaderLabels(
            ['MUSTERI_ID', 'MUSTERI_YAS', 'MAGAZA_ID'])

        for i in range(table_row):
            for j in range(table_column):
                self.musteritable.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))



    def musterigiris(self):
        musteriid = int(self.musteriid.text())
        musteriyas = int(self.musteriyas.text())
        musterimagazaid = int(self.linestokmagazaid_2.text())


        result1 = self.db.cursor()

        result1.execute("INSERT INTO MUSTERI (musterid, musteriyas, magazaid) VALUES  (?,?,?)",
                        (musteriid, musteriyas, musterimagazaid))

        try:
            result1.fetchall()
        except:
            self.semtsonuc_4.setText("Kapasite sayisi dolu yeni musteri giremez !!!!!!!")

        self.db.commit()


    def magazasilme(self):
        query = "SELECT * FROM MAGAZA;"
        cursor = self.db.cursor()
        cursor.execute(query)
        recors = cursor.fetchall()

        table_row = len(recors)
        self.magazatable.setRowCount(table_row)

        table_column = len(recors[0])
        self.magazatable.setColumnCount(table_column)

        self.magazatable.setHorizontalHeaderLabels(
            ['MAGAZA_ID', 'MAGAZA_ISIM', 'KAT_ID' , 'AVM_ID' , 'KASA_SAYISI' ,'SEKTOR' , 'MUDUR_ID', 'KAPASITE'])

        for i in range(table_row):
            for j in range(table_column):
                self.magazatable.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))

        query = "SELECT * FROM URUN;"
        cursor = self.db.cursor()
        cursor.execute(query)
        recors = cursor.fetchall()

        table_row = len(recors)
        self.tableWidget.setRowCount(table_row)

        table_column = len(recors[0])
        self.tableWidget.setColumnCount(table_column)

        self.tableWidget.setHorizontalHeaderLabels(
            ['URUN_ID', 'FIYAT', 'URUN_TIP', 'MAGAZA_ID', 'SATIS_ADET', 'STOK_ADET'])

        for i in range(table_row):
            for j in range(table_column):
                self.tableWidget.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))

        query = "SELECT * FROM PERSONEL;"
        cursor = self.db.cursor()
        cursor.execute(query)
        recors = cursor.fetchall()

        table_row = len(recors)
        self.tableWidget_2.setRowCount(table_row)

        table_column = len(recors[0])
        self.tableWidget_2.setColumnCount(table_column)

        self.tableWidget_2.setHorizontalHeaderLabels(
            ['PERSONEL_ID', 'PERSONEL_TIP', 'MAGAZA_ID', 'AVMDID', 'KAT_ID', 'ISIM', 'CINSIYET', 'YAS'])

        for i in range(table_row):
            for j in range(table_column):
                self.tableWidget_2.setItem(i, j, QtWidgets.QTableWidgetItem(str(recors[i][j])))



        QTimer.singleShot(1000, self.magazasilme)

    def magazasilmekontrol(self):
        magazaiddd = int(self.magazaidd.text())

        print(magazaiddd)
        result1 = self.db.cursor()


        result1.execute("DELETE FROM MAGAZA WHERE magazaid = ?",(magazaiddd))

        #self.cursor.execute("DELETE FROM İlçeler WHERE Name = ?", (self.ilce_adi));

        try:
            result1.fetchall()
        except:
            self.semtsonuc_5.setText("Bütün Tablolardan Silindi.")


        self.db.commit()




def main():


    app = QtWidgets.QApplication(sys.argv)
    window = Ui()
    window.calisan()
    window.kazanc()
    window.ortalamayas()
    window.sektor()
    window.urunstok()
    window.semtsilinemez()
    window.fiyatkontrol2()
    window.stokkontrol()
    window.musterikontrol()
    window.magazasilme()

    window.insert22.clicked.connect(window.insert2)
    window.inserturun.clicked.connect(window.inserturunfun)
    window.insertstok.clicked.connect(window.insertsatis)
    window.insertmusteri.clicked.connect(window.musterigiris)
    window.deletemagaza.clicked.connect(window.magazasilmekontrol)

    app.exec_()


if __name__ == "__main__":
    main()
