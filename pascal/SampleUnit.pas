unit SampleUnit;

// インターフェイス部
interface

// 型宣言
type
    TMusume = class

        // プライベートスコープ
        private

            // フィールド
            m_Age: integer;
            m_BirthDate: TDateTime;

            // メソッド
            function CalcAge: integer;

            // プロパティプロシージャ
            function getAge: integer;

            function  getBirthDate: TDateTime;
            procedure setBirthDate( const birthDate: TDateTime );

        // パブリックスコープ
        public

            // フィールド
            Name: string;

            // プロパティ
            property Age: integer read getAge;
            property BirthDate: TDateTime read getBirthDate write setBirthDate;

            // メソッド
            procedure Introduce;

            // コンストラクタ
            constructor Create( nam: String );

            // デストラクタ
            //destructor Destroy;

    end;


// 実装部
implementation

uses
    SysUtils;

// コンストラクタ
constructor TMusume.Create( nam: String );
begin

    Name := nam;

end;

// プロパティプロシージャ
function TMusume.getAge: integer;
begin

    result := m_Age;

end;

procedure TMusume.setBirthDate( const birthDate: TDateTime );
begin

    m_BirthDate := birthDate;
    m_Age := CalcAge;

end;

function TMusume.getBirthDate: TDateTime;
begin

    result := m_BirthDate;

end;


// メソッド
procedure TMusume.Introduce;
var
    y, m ,d: Word;

begin

    DecodeDate( m_BirthDate, y, m, d );

    Write( Name, ' ' );
    Write( y, '年', m, '月', d, '日生まれ ' );
    Writeln( m_Age, '歳' );

end;


function TMusume.CalcAge: integer;
var
    age: Word;
    by, bm, bd: Word;
    ny, nm, nd: Word;

begin

    DecodeDate( m_BirthDate, by, bm, bd );
    DecodeDate( Now, ny, nm, nd );

    age := ny - by;

    if ( bm > nm ) or ( ( bm = nm ) and ( bd > nd ) ) then
        age := age - 1;

    result := age;

end;


end.