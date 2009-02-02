#include <QtGui>
#include "finddialog.h"
#include "gotocelldialog.h"
#include "mainwindow.h"
#include "sortdialog.h"
#include "spreadsheet.h"

MainWindow::MainWindow()
{
  spreadsheet = new Spreadsheet;
  setCentralWidget(spreadsheet);
  createActions();
  createMenus();
  createContextMenu();
  createToolBars();
  createStatusBar();
  readSettings();
  findDialog = 0;
  setWindowIcon(QIcon(":/images/icon.png"));
  setCurrentFile("");
}

void MainWindow::createActions()
{
  newAction = new QAction(tr("&New"), this);
  newAction->setIcon(QIcon(":/images/new.png"));
  newAction->setShortcut(tr("Ctrl+N"));
  newAction->setStatusTip(tr("Create a new spreadsheet file"));
  connect(newAction, SIGNAL(triggered()), this, SLOT(newFile()));

  openAction = new QAction(tr("&Open"), this);
  openAction->setIcon(QIcon(":/images/open.png"));
  openAction->setShortcut(tr("Ctrl+O"));
  openAction->setStatusTip(tr("Open spreadsheet file"));
  connect(openAction, SIGNAL(triggered()), this, SLOT(open()));

  saveAction = new QAction(tr("Save"), this);
  saveAction->setIcon(QIcon(":/images/save.png"));
  saveAction->setStatusTip(tr("Save current spreadsheet file"));
  connect(saveAction, SIGNAL(triggered()), this, SLOT(save()));

  saveAsAction = new QAction(tr("Save As"), this);
  saveAsAction->setIcon(QIcon(":/images/saveas.png"));
  saveAsAction->setStatusTip(tr("Save current spreadsheet as a new file"));
  connect(saveAsAction, SIGNAL(triggered()), this, SLOT(saveAs()));

  for(int i=0;i<MaxRecentFiles;++i){
    recentFileActions[i] = new QAction(this);
    recentFileActions[i]->setVisible(false);
    connect(recentFileActions[i], SIGNAL(triggered()),
	    this, SLOT(openRecentFile()));
  }

  selectAllAction = new QAction(tr("&All"), this);
  selectAllAction->setShortcut(tr("Ctrl+A"));
  selectAllAction->setStatusTip(tr("Select all the cells in the spreadsheet"));
  connect(selectAllAction, SIGNAL(triggered()),
	  spreadsheet, SLOT(selectALL()));

  showGridAction = new QAction(tr("&Show Grid"),this);
  showGridAction->setCheckable(true);
  showGridAction->setChecked(spreadsheet->showGrid());
  showGridAction->setStatusTip(tr("Show or hide the spreadsheet's grid"));
  connect(showGridAction, SIGNAL(toggled(bool)),
	  spreadsheet, SLOT(setShowGrid(bool)));

  aboutQtAction = new QAction(tr("About &Qt"), this);
  aboutQtAction->setStatusTip(tr("Show the Qt library's About box"));
  connect(aboutQtAction, SIGNAL(triggered()), qApp, SLOT(aboutQt()));
}
