/*
 * 情報編集(web)2014
 * 最終課題制作テンプレート
 * 2014.07.11
 *
 */

EneTable ene; //ファイル読込のためのクラス
String[] filelist; //データファイル名リスト
int dataNum = 0; //データ番号
int hour = 0; //現在の時間（0〜23）

//初期化
void setup() {
  // 画面初期化
  size(800, 600);
  noStroke();
  frameRate(30);
  textSize(14);
  // ファイルリストの読み込み
  filelist = loadStrings("filelist.txt"); 
  // データ読み込み用クラスEneTableをインスタンス化（初期化）
  ene = new EneTable(filelist[dataNum]);
}

// 結果を表示
void draw() {
  // 背景
  background(0);
  fill(255);
  pushMatrix();
  translate(width/2, height/2);

  // ================================================
  // !!!!! このループ内でデータを表現する !!!!!
  for (int i = 0; i < ene.data.length-1; i++) {
    // データの数値を表示
    // ene.data[i][hour] で値を取得する
    float col = map(ene.data[i][hour], 0, 1400, 0, 255);
    fill(col, col, 255-col);
    float size = map(ene.data[i][hour], 0, 1400, 1, 550);
    ellipse(0,-2, size, size);
    rotate(PI * 2.0 / float(ene.data.length));
  }
  popMatrix();
  // ================================================

  // 日付を画面に出力
  fill(255);
  text(ene.date + " "  + hour + ":00", 5, 20);

  // データ番号を更新
  hour++;
  if (hour > 23) {
    hour = 0;
    dataNum++;
    // もしファイル数よりも多ければ最初に戻る
    if (dataNum > filelist.length - 1) {
      dataNum = 0;
    }
    // クラスを再度初期化して次のデータファイルを読み込む
    ene = new EneTable(filelist[dataNum]);
  }
}
// EneTable
// 電力データ読み込み用クラス

class EneTable {
  String date;  // 日付
  int data[][]; // データ

  // コンストラクタ（初期化関数）
  // ファイルを指定して、データをパース
  EneTable(String filename) {
    String[] rows = loadStrings(filename);
    String[] header = split(rows[0], ",");
    date = header[1];    
    data = new int[rows.length - 1][];

    for (int i = 1; i < rows.length - 1; i++) {
      int[] row = int(split(rows[i], ","));
      data[i - 1] = (int[]) subset(row, 1);
    }
  }

  //行の最小値を求める
  float getRowsMin(int row) {
    float m = Float.MAX_VALUE;
    for (int col = 0; col < data[row].length; col++) {
      if (data[row][col] < m) {
        m = data[row][col];
      }
    }
    return m;
  }
  
  //行の最大値を求める
  float getRowsMax(int row) {
    float m = -Float.MAX_VALUE;
    for (int col = 0; col < data[row].length; col++) {
      if (data[row][col] > m) {
        m = data[row][col];
      }
    }
    return m;
  }
}

