   M S B A M L   `   `   `  ���� D  @Transport, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null3clr-namespace:Transport.DriverTransport.Driver      Transport.Driver.mojedane   W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     @d2http://schemas.microsoft.com/expression/blend/2008     0localclr-namespace:Transport.Driver     .��� ���#1e1e1e  � RowDefinitions  �� $
��Auto ��� $��* ��� $��* ��� $��* �.+�� ���#393E46$��80��$	��Top=�$��0��.+��� $��Dane użytkownika��$
��Auto��$��1��$��46�����#FFFFFF$��Center=�$��Center=�$��25(�&   System.Windows.Controls.DataGrid  -   $��daneGrid��$��0,40,0,0q�$	��100��$	��780��   AutoGenerateColumns$ False��   RowBackground
 ����    
IsReadOnly$
 True��$��1������  �� 
StartPoint$	 0,0&� �� EndPoint$	 1,0&� �� Opacity$	 0.8Q�.���  � Color$ #222831�� � Offset$ 0Q�� $ #00ADB5��$ 1Q�	   	CellStyle	 �� 
 �� 
TargetType*  $System.Windows.Controls.DataGridCell"
  .���  �� Property � �� �� Value
 �����   ColumnHeaderStyle �� =  7System.Windows.Controls.Primitives.DataGridColumnHeader"
  .���  � �� �#393E46��  � ��
 �������  � �� �#555555��  � ��$ 0,0,1,1q���  � ��$ 10q���  � ��$
 Auto��   Columns 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumn   Header$ Imię��   Width5  /System.Windows.Controls.DataGridLengthConverter$ * 1  +System.Windows.Controls.DataGridBoundColumn   Binding �� *	firstName+  $ Nazwisko��$ *  �� *
lastName+  $ Pesel��$ *  �� *pesel+  $ Miasto��$ *  �� *city+  $ Ulica��$ *  �� *street+  $ Numer ulicy��$ *  �� *
street_num+  $ Numer lokalu��$ *  �� *
flat_num+  $ Data urodzenia��$ *  �� *dataUrodzenia+  $ Numer telefonu��$ *  �� *	phone_num+�� -   $��passwordChange��$��3��$��20��$	��110��$��Zmień hasło���� -   $��goback��$��Right=�$��Bottom=�$��50��$��50��
������ $��0q�$��3��.���� $5��/D:\project_oop\Transport\images\back_button.png��