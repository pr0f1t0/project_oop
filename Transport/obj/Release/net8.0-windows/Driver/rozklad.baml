   M S B A M L   `   `   `  ���� D  @Transport, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null3clr-namespace:Transport.DriverTransport.Driver      Transport.Driver.rozklad   W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     @d2http://schemas.microsoft.com/expression/blend/2008     0localclr-namespace:Transport.Driver     .��� ���#1e1e1e  � RowDefinitions  �� $
��Auto ��� $
��Auto ��� $
��Auto � � ColumnDefinitions �� $
��Auto ��� $��* �.+�� ���#393E46$��2��$��80��$	��Top=�.+��� $��Rozkład jazdy��$
��Auto��$��46�����#FFFFFF$��Center=�$��Center=�$��25(�� $	��350��$	��200��$��1��$
��Left=�.+���  �� Orientation$ Vertical=�$
��Left=�.+��� $��Wybierz przystanek:��
�������$��20(��� -   $��PrzystankiCombo��$	��200�� �� SelectedIndex$ 0���� $��30��$	��200��$��Bottom=�.+��� -    ��Name$ ShowSchedule��$��Pokaż rozkład��$��20��$	��200��&   System.Windows.Controls.DataGrid  -   $��rozkladGrid��$��1��$��1��$��0,40,0,0q�$	��300��$	��300��   AutoGenerateColumns$ False��   RowBackground
 ����    
IsReadOnly$
 True������  �� 
StartPoint$	 0,0&�	 �� EndPoint$		 1,0&�
 �� Opacity$	
 0.8Q�.���  � Color$ #222831�� � Offset$ 0Q�� $ #00ADB5��$ 1Q�   	CellStyle ��  �� 
TargetType*  $System.Windows.Controls.DataGridCell"  .���  �� Property � �� �� Value
 �����   ColumnHeaderStyle �� =  7System.Windows.Controls.Primitives.DataGridColumnHeader"  .���  � �� �#393E46��  � ��
 �������  � �� �#555555��  � ��$ 0,0,1,1q���  � ��$ 10q���  � ��$
 Auto��   Columns 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumn   Header$ Linia��   Width5  /System.Windows.Controls.DataGridLengthConverter$ * 1  +System.Windows.Controls.DataGridBoundColumn   Binding �� *
line_num+  $ Czas odjazdu��$ *  �� *departure_time+�� -   $��goback��$��Right=�$��Bottom=�$��2��$��1��$��50��$��50��
������ $��0q�.���� $5��/D:\project_oop\Transport\images\back_button.png��