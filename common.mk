# GNUmakefileの雛型
# コンパイラやコマンドの指定,  パターンルールなどの
# makefileで共通に使われる部分を抜き出したもの
# makefileの中で include common.mkと書けば有効になる
# makefile側でインクルードパスと実行バイナリを保存するパスを
# 指定し，さらにvpathの設定をする必要がある．
# カレントディレクトリ内で完結する場合は，その設定は不要
# 以下はmakefileの例

# BINDIR= ../bin/
# include_dirs:=  ../include
# CPPFLAGS+= $(addprefix -I,$(include_dirs))
# vpath % $(BINDIR)
# vpath %.h $(include_dirs)
# include common.mk

# 以下本体 ------------------------------------------------

# コマンド群（移植性を高めるために変数にする)
MV:= mv -f
RM:= rm -f
AR:= ar ruc
SED:= sed
GREP:= grep -q -E

# CとC++のコンパイラとオプションの設定
CC= gcc
CFLAGS= -O3 -Wall

CXX= g++
CXXFLAGS= -O3 -Wall

# DEBUG変数を定義していれば，デバッグモードでコンパイル
ifdef DEBUG
    CFLAGS= -Wall -g
    CXXFLAGS= -Wall -g
    CPPFLAGS+= -DDEBUG
endif

CPPFLAGS+= $(addprefix -L,$(lib_dirs))
CPPFLAGS+= $(addprefix -I,$(include_dirs))

cdepend:= $(addprefix .,$(subst .c,.d,$(wildcard *.c)))
cxxdepend:= $(addprefix .,$(subst .cpp,.d,$(wildcard *.cpp)))

ifneq "$(MAKECMDGOALS)" "clean"
    ifneq "$(cdepend)" ""
        -include $(cdepend)
    endif
    ifneq "$(cxxdepend)" ""
        -include $(cxxdepend)
    endif
endif

# .hファイルの依存関係を自動抽出するルール
.%.d: %.c
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$;				\
	$(SED) -e 's|\($*\)\.o[ :]*|\1.o $@ \1: |g' < $@.$$$$ > $@;	\
	$(RM) $@.$$$$

% : %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $< -o $(BINDIR)$@ $(LDLIBS) -lm

% : %.f
	$(FC) $(FFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< -o $(BINDIR)$@ 

# 疑似ターゲットの設定
.PHONY: all clean install

all:

clean:
	@ echo "cleanning ..."
	@ $(RM) .*.d *.o


