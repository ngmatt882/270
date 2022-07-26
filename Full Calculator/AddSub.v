module AddSub(a,b,co,r,ovf);
    input [10:0] a,b;
    input co;
    output [10:0] r;
    output ovf;
    wire [10:0] cb;
    wire cout1, cout2, cout3, cout4, cout5, cout6, cout7, cout8, cout9, cout10, cout11;
    
    assign cb = co ? ~b : b;
    
    FA f1(a[0],cb[0],co,cout1,r[0]);
    FA f2(a[1],cb[1],cout1,cout2,r[1]);
    FA f3(a[2],cb[2],cout2,cout3,r[2]);
    FA f4(a[3],cb[3],cout3,cout4,r[3]);
    FA f5(a[4],cb[4],cout4,cout5,r[4]);
    FA f6(a[5],cb[5],cout5,cout6,r[5]);
    FA f7(a[6],cb[6],cout6,cout7,r[6]);
    FA f8(a[7],cb[7],cout7,cout8,r[7]);
    FA f9(a[8],cb[8],cout8,cout9,r[8]);
    FA f10(a[9],cb[9],cout9,cout10,r[9]);
    FA f11(a[10],cb[10],cout10,cout11,r[10]);
    
    assign ovf = cout10 ^ cout11;
endmodule