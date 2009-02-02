{$APPTYPE CONSOLE}

program LearningDelphi;

uses
    SysUtils,
    SampleUnit in 'SampleUnit.pas';

var
    // クラス型変数を宣言
    aibon: TMusume;

begin

    // インスタンスを生成
    aibon := TMusume.Create( '加護亜依' );

    // プロパティ値を設定
    aibon.BirthDate := EncodeDate( 1988, 2, 7 );

    // メソッドを呼び出し
    aibon.Introduce;

    // インスタンスを破棄
    aibon.Free;

    // 終了メッセージを表示
    Write( 'Press any key to continue' );
    Readln;

end.