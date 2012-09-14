$(function () {
  
   
  //社員出金日数合計をセット
  cals_syain_nisu_kei();
  
  //社員出金日数合計
  function cals_syain_nisu_kei() {
    
    var i=0;
    var num;
    var total=0;  
    
    //社員ごとの日数計
    $("[id^=syain_nisu_]").each(function(i){
        num = Number($(this).text());
        if (isNaN(num)) {num = 0};
        total = total + num;
    })
    $("#syain_nisu_kei").text(total);
    
    
    var i=1;
    total=0;  
    while(i<32){
      
      $("[id^=syain_" + Number(i) + "_]").each(function(i){
          num = Number($(this).text());
          if (isNaN(num)) {num = 0};
          total = total + num;
      })
      
      $("[id^=syain_" + Number(i) + "_]")
      i=i+1;
    };
  
  };
  
});
