module shift_unit_32(A, shamt, shift_to_right, z);

	// Define inputs
	input [31:0] A;
	input [4:0] shamt; // shamt amount ranges from 0 ("00000") to 31 ("11111")
	input shift_to_right; // Indicates the direction of the shamt. If 1, shamt to right, else to left.

	// Define outputs
	output [31:0] z;

	// Internal signals in case we need to shift to right
	wire x31, x30, x29, x28, x27, x26, x25, x24, x23, x22, x21, x20, x19, x18, x17, x16;
	wire x15, x14, x13, x12, x11, x10, x9, x8, x7, x6, x5, x4, x3, x2, x1, x0;
	wire y31, y30, y29, y28, y27, y26, y25, y24, y23, y22, y21, y20, y19, y18, y17, y16;
	wire y15, y14, y13, y12, y11, y10, y9, y8, y7, y6, y5, y4, y3, y2, y1, y0;

	// Internal signals for first row of muxes outputs
	wire r31, r30, r29, r28, r27, r26, r25, r24, r23, r22, r21, r20, r19, r18, r17, r16;
	wire r15, r14, r13, r12, r11, r10, r9, r8, r7, r6, r5, r4, r3, r2, r1, r0;

	// Internal signals for second row of muxes outputs
	wire s31, s30, s29, s28, s27, s26, s25, s24, s23, s22, s21, s20, s19, s18, s17, s16;
	wire s15, s14, s13, s12, s11, s10, s9, s8, s7, s6, s5, s4, s3, s2, s1, s0;

	// Internal signals for third row of muxes outputs
	wire t31, t30, t29, t28, t27, t26, t25, t24, t23, t22, t21, t20, t19, t18, t17, t16;
	wire t15, t14, t13, t12, t11, t10, t9, t8, t7, t6, t5, t4, t3, t2, t1, t0;

	// Internal signals for fourth row of muxes outputs
	wire u31, u30, u29, u28, u27, u26, u25, u24, u23, u22, u21, u20, u19, u18, u17, u16;
	wire u15, u14, u13, u12, u11, u10, u9, u8, u7, u6, u5, u4, u3, u2, u1, u0;

	// Internal signals for fifth row of muxes outputs
	wire v31, v30, v29, v28, v27, v26, v25, v24, v23, v22, v21, v20, v19, v18, v17, v16;
	wire v15, v14, v13, v12, v11, v10, v9, v8, v7, v6, v5, v4, v3, v2, v1, v0;


	// Assign LSB depending on type of shamt:
	// Logical shift --> LSB <= 0
	// Arithmetic shift --> LSB <= A[0]
	// Rotation shift --> LSB <= depends on A
	assign LSB = 1'b0;

	// In case shift_to_right, make sure we flip inputs
	mux mux_x31 (.sel(shift_to_right), .src0(A[31]), .src1(A[0]), .z(x31));
	mux mux_x30 (.sel(shift_to_right), .src0(A[30]), .src1(A[1]), .z(x30));
	mux mux_x29 (.sel(shift_to_right), .src0(A[29]), .src1(A[2]), .z(x29));
	mux mux_x28 (.sel(shift_to_right), .src0(A[28]), .src1(A[3]), .z(x28));
	mux mux_x27 (.sel(shift_to_right), .src0(A[27]), .src1(A[4]), .z(x27));
	mux mux_x26 (.sel(shift_to_right), .src0(A[26]), .src1(A[5]), .z(x26));
	mux mux_x25 (.sel(shift_to_right), .src0(A[25]), .src1(A[6]), .z(x25));
	mux mux_x24 (.sel(shift_to_right), .src0(A[24]), .src1(A[7]), .z(x24));
	mux mux_x23 (.sel(shift_to_right), .src0(A[23]), .src1(A[8]), .z(x23));
	mux mux_x22 (.sel(shift_to_right), .src0(A[22]), .src1(A[9]), .z(x22));
	mux mux_x21 (.sel(shift_to_right), .src0(A[21]), .src1(A[10]), .z(x21));
	mux mux_x20 (.sel(shift_to_right), .src0(A[20]), .src1(A[11]), .z(x20));
	mux mux_x19 (.sel(shift_to_right), .src0(A[19]), .src1(A[12]), .z(x19));
	mux mux_x18 (.sel(shift_to_right), .src0(A[18]), .src1(A[13]), .z(x18));
	mux mux_x17 (.sel(shift_to_right), .src0(A[17]), .src1(A[14]), .z(x17));
	mux mux_x16 (.sel(shift_to_right), .src0(A[16]), .src1(A[15]), .z(x16));
	mux mux_x15 (.sel(shift_to_right), .src0(A[15]), .src1(A[16]), .z(x15));
	mux mux_x14 (.sel(shift_to_right), .src0(A[14]), .src1(A[17]), .z(x14));
	mux mux_x13 (.sel(shift_to_right), .src0(A[13]), .src1(A[18]), .z(x13));
	mux mux_x12 (.sel(shift_to_right), .src0(A[12]), .src1(A[19]), .z(x12));
	mux mux_x11 (.sel(shift_to_right), .src0(A[11]), .src1(A[20]), .z(x11));
	mux mux_x10 (.sel(shift_to_right), .src0(A[10]), .src1(A[21]), .z(x10));
	mux mux_x9 (.sel(shift_to_right), .src0(A[9]), .src1(A[22]), .z(x9));
	mux mux_x8 (.sel(shift_to_right), .src0(A[8]), .src1(A[23]), .z(x8));
	mux mux_x7 (.sel(shift_to_right), .src0(A[7]), .src1(A[24]), .z(x7));
	mux mux_x6 (.sel(shift_to_right), .src0(A[6]), .src1(A[25]), .z(x6));
	mux mux_x5 (.sel(shift_to_right), .src0(A[5]), .src1(A[26]), .z(x5));
	mux mux_x4 (.sel(shift_to_right), .src0(A[4]), .src1(A[27]), .z(x4));
	mux mux_x3 (.sel(shift_to_right), .src0(A[3]), .src1(A[28]), .z(x3));
	mux mux_x2 (.sel(shift_to_right), .src0(A[2]), .src1(A[29]), .z(x2));
	mux mux_x1 (.sel(shift_to_right), .src0(A[1]), .src1(A[30]), .z(x1));
	mux mux_x0 (.sel(shift_to_right), .src0(A[0]), .src1(A[31]), .z(x0));

	// Build the first row of muxes (shamt 0 or 1)
	mux mux_s0_b31 (.sel(shamt[0]), .src0(x31), .src1(x30), .z(r31));
	mux mux_s0_b30 (.sel(shamt[0]), .src0(x30), .src1(x29), .z(r30));
	mux mux_s0_b29 (.sel(shamt[0]), .src0(x29), .src1(x28), .z(r29));
	mux mux_s0_b28 (.sel(shamt[0]), .src0(x28), .src1(x27), .z(r28));
	mux mux_s0_b27 (.sel(shamt[0]), .src0(x27), .src1(x26), .z(r27));
	mux mux_s0_b26 (.sel(shamt[0]), .src0(x26), .src1(x25), .z(r26));
	mux mux_s0_b25 (.sel(shamt[0]), .src0(x25), .src1(x24), .z(r25));
	mux mux_s0_b24 (.sel(shamt[0]), .src0(x24), .src1(x23), .z(r24));
	mux mux_s0_b23 (.sel(shamt[0]), .src0(x23), .src1(x22), .z(r23));
	mux mux_s0_b22 (.sel(shamt[0]), .src0(x22), .src1(x21), .z(r22));
	mux mux_s0_b21 (.sel(shamt[0]), .src0(x21), .src1(x20), .z(r21));
	mux mux_s0_b20 (.sel(shamt[0]), .src0(x20), .src1(x19), .z(r20));
	mux mux_s0_b19 (.sel(shamt[0]), .src0(x19), .src1(x18), .z(r19));
	mux mux_s0_b18 (.sel(shamt[0]), .src0(x18), .src1(x17), .z(r18));
	mux mux_s0_b17 (.sel(shamt[0]), .src0(x17), .src1(x16), .z(r17));
	mux mux_s0_b16 (.sel(shamt[0]), .src0(x16), .src1(x15), .z(r16));
	mux mux_s0_b15 (.sel(shamt[0]), .src0(x15), .src1(x14), .z(r15));
	mux mux_s0_b14 (.sel(shamt[0]), .src0(x14), .src1(x13), .z(r14));
	mux mux_s0_b13 (.sel(shamt[0]), .src0(x13), .src1(x12), .z(r13));
	mux mux_s0_b12 (.sel(shamt[0]), .src0(x12), .src1(x11), .z(r12));
	mux mux_s0_b11 (.sel(shamt[0]), .src0(x11), .src1(x10), .z(r11));
	mux mux_s0_b10 (.sel(shamt[0]), .src0(x10), .src1(x9), .z(r10));
	mux mux_s0_b9 (.sel(shamt[0]), .src0(x9), .src1(x8), .z(r9));
	mux mux_s0_b8 (.sel(shamt[0]), .src0(x8), .src1(x7), .z(r8));
	mux mux_s0_b7 (.sel(shamt[0]), .src0(x7), .src1(x6), .z(r7));
	mux mux_s0_b6 (.sel(shamt[0]), .src0(x6), .src1(x5), .z(r6));
	mux mux_s0_b5 (.sel(shamt[0]), .src0(x5), .src1(x4), .z(r5));
	mux mux_s0_b4 (.sel(shamt[0]), .src0(x4), .src1(x3), .z(r4));
	mux mux_s0_b3 (.sel(shamt[0]), .src0(x3), .src1(x2), .z(r3));
	mux mux_s0_b2 (.sel(shamt[0]), .src0(x2), .src1(x1), .z(r2));
	mux mux_s0_b1 (.sel(shamt[0]), .src0(x1), .src1(x0), .z(r1));
	mux mux_s0_b0 (.sel(shamt[0]), .src0(x0), .src1(LSB), .z(r0));

	// Build the second row of muxes (shamt 0 or 2)
	mux mux_s1_b31 (.sel(shamt[1]), .src0(r31), .src1(r29), .z(s31));
	mux mux_s1_b30 (.sel(shamt[1]), .src0(r30), .src1(r28), .z(s30));
	mux mux_s1_b29 (.sel(shamt[1]), .src0(r29), .src1(r27), .z(s29));
	mux mux_s1_b28 (.sel(shamt[1]), .src0(r28), .src1(r26), .z(s28));
	mux mux_s1_b27 (.sel(shamt[1]), .src0(r27), .src1(r25), .z(s27));
	mux mux_s1_b26 (.sel(shamt[1]), .src0(r26), .src1(r24), .z(s26));
	mux mux_s1_b25 (.sel(shamt[1]), .src0(r25), .src1(r23), .z(s25));
	mux mux_s1_b24 (.sel(shamt[1]), .src0(r24), .src1(r22), .z(s24));
	mux mux_s1_b23 (.sel(shamt[1]), .src0(r23), .src1(r21), .z(s23));
	mux mux_s1_b22 (.sel(shamt[1]), .src0(r22), .src1(r20), .z(s22));
	mux mux_s1_b21 (.sel(shamt[1]), .src0(r21), .src1(r19), .z(s21));
	mux mux_s1_b20 (.sel(shamt[1]), .src0(r20), .src1(r18), .z(s20));
	mux mux_s1_b19 (.sel(shamt[1]), .src0(r19), .src1(r17), .z(s19));
	mux mux_s1_b18 (.sel(shamt[1]), .src0(r18), .src1(r16), .z(s18));
	mux mux_s1_b17 (.sel(shamt[1]), .src0(r17), .src1(r15), .z(s17));
	mux mux_s1_b16 (.sel(shamt[1]), .src0(r16), .src1(r14), .z(s16));
	mux mux_s1_b15 (.sel(shamt[1]), .src0(r15), .src1(r13), .z(s15));
	mux mux_s1_b14 (.sel(shamt[1]), .src0(r14), .src1(r12), .z(s14));
	mux mux_s1_b13 (.sel(shamt[1]), .src0(r13), .src1(r11), .z(s13));
	mux mux_s1_b12 (.sel(shamt[1]), .src0(r12), .src1(r10), .z(s12));
	mux mux_s1_b11 (.sel(shamt[1]), .src0(r11), .src1(r9), .z(s11));
	mux mux_s1_b10 (.sel(shamt[1]), .src0(r10), .src1(r8), .z(s10));
	mux mux_s1_b9 (.sel(shamt[1]), .src0(r9), .src1(r7), .z(s9));
	mux mux_s1_b8 (.sel(shamt[1]), .src0(r8), .src1(r6), .z(s8));
	mux mux_s1_b7 (.sel(shamt[1]), .src0(r7), .src1(r5), .z(s7));
	mux mux_s1_b6 (.sel(shamt[1]), .src0(r6), .src1(r4), .z(s6));
	mux mux_s1_b5 (.sel(shamt[1]), .src0(r5), .src1(r3), .z(s5));
	mux mux_s1_b4 (.sel(shamt[1]), .src0(r4), .src1(r2), .z(s4));
	mux mux_s1_b3 (.sel(shamt[1]), .src0(r3), .src1(r1), .z(s3));
	mux mux_s1_b2 (.sel(shamt[1]), .src0(r2), .src1(r0), .z(s2));
	mux mux_s1_b1 (.sel(shamt[1]), .src0(r1), .src1(LSB), .z(s1));
	mux mux_s1_b0 (.sel(shamt[1]), .src0(r0), .src1(LSB), .z(s0));

	// Build the third row of muxes (shamt 0 or 4)
	mux mux_s2_b31 (.sel(shamt[2]), .src0(s31), .src1(s27), .z(t31));
	mux mux_s2_b30 (.sel(shamt[2]), .src0(s30), .src1(s26), .z(t30));
	mux mux_s2_b29 (.sel(shamt[2]), .src0(s29), .src1(s25), .z(t29));
	mux mux_s2_b28 (.sel(shamt[2]), .src0(s28), .src1(s24), .z(t28));
	mux mux_s2_b27 (.sel(shamt[2]), .src0(s27), .src1(s23), .z(t27));
	mux mux_s2_b26 (.sel(shamt[2]), .src0(s26), .src1(s22), .z(t26));
	mux mux_s2_b25 (.sel(shamt[2]), .src0(s25), .src1(s21), .z(t25));
	mux mux_s2_b24 (.sel(shamt[2]), .src0(s24), .src1(s20), .z(t24));
	mux mux_s2_b23 (.sel(shamt[2]), .src0(s23), .src1(s19), .z(t23));
	mux mux_s2_b22 (.sel(shamt[2]), .src0(s22), .src1(s18), .z(t22));
	mux mux_s2_b21 (.sel(shamt[2]), .src0(s21), .src1(s17), .z(t21));
	mux mux_s2_b20 (.sel(shamt[2]), .src0(s20), .src1(s16), .z(t20));
	mux mux_s2_b19 (.sel(shamt[2]), .src0(s19), .src1(s15), .z(t19));
	mux mux_s2_b18 (.sel(shamt[2]), .src0(s18), .src1(s14), .z(t18));
	mux mux_s2_b17 (.sel(shamt[2]), .src0(s17), .src1(s13), .z(t17));
	mux mux_s2_b16 (.sel(shamt[2]), .src0(s16), .src1(s12), .z(t16));
	mux mux_s2_b15 (.sel(shamt[2]), .src0(s15), .src1(s11), .z(t15));
	mux mux_s2_b14 (.sel(shamt[2]), .src0(s14), .src1(s10), .z(t14));
	mux mux_s2_b13 (.sel(shamt[2]), .src0(s13), .src1(s9), .z(t13));
	mux mux_s2_b12 (.sel(shamt[2]), .src0(s12), .src1(s8), .z(t12));
	mux mux_s2_b11 (.sel(shamt[2]), .src0(s11), .src1(s7), .z(t11));
	mux mux_s2_b10 (.sel(shamt[2]), .src0(s10), .src1(s6), .z(t10));
	mux mux_s2_b9 (.sel(shamt[2]), .src0(s9), .src1(s5), .z(t9));
	mux mux_s2_b8 (.sel(shamt[2]), .src0(s8), .src1(s4), .z(t8));
	mux mux_s2_b7 (.sel(shamt[2]), .src0(s7), .src1(s3), .z(t7));
	mux mux_s2_b6 (.sel(shamt[2]), .src0(s6), .src1(s2), .z(t6));
	mux mux_s2_b5 (.sel(shamt[2]), .src0(s5), .src1(s1), .z(t5));
	mux mux_s2_b4 (.sel(shamt[2]), .src0(s4), .src1(s0), .z(t4));
	mux mux_s2_b3 (.sel(shamt[2]), .src0(s3), .src1(LSB), .z(t3));
	mux mux_s2_b2 (.sel(shamt[2]), .src0(s2), .src1(LSB), .z(t2));
	mux mux_s2_b1 (.sel(shamt[2]), .src0(s1), .src1(LSB), .z(t1));
	mux mux_s2_b0 (.sel(shamt[2]), .src0(s0), .src1(LSB), .z(t0));

	// Build the fourth row of muxes (shamt 0 or 8)
	mux mux_s3_b31 (.sel(shamt[3]), .src0(t31), .src1(t23), .z(u31));
	mux mux_s3_b30 (.sel(shamt[3]), .src0(t30), .src1(t22), .z(u30));
	mux mux_s3_b29 (.sel(shamt[3]), .src0(t29), .src1(t21), .z(u29));
	mux mux_s3_b28 (.sel(shamt[3]), .src0(t28), .src1(t20), .z(u28));
	mux mux_s3_b27 (.sel(shamt[3]), .src0(t27), .src1(t19), .z(u27));
	mux mux_s3_b26 (.sel(shamt[3]), .src0(t26), .src1(t18), .z(u26));
	mux mux_s3_b25 (.sel(shamt[3]), .src0(t25), .src1(t17), .z(u25));
	mux mux_s3_b24 (.sel(shamt[3]), .src0(t24), .src1(t16), .z(u24));
	mux mux_s3_b23 (.sel(shamt[3]), .src0(t23), .src1(t15), .z(u23));
	mux mux_s3_b22 (.sel(shamt[3]), .src0(t22), .src1(t14), .z(u22));
	mux mux_s3_b21 (.sel(shamt[3]), .src0(t21), .src1(t13), .z(u21));
	mux mux_s3_b20 (.sel(shamt[3]), .src0(t20), .src1(t12), .z(u20));
	mux mux_s3_b19 (.sel(shamt[3]), .src0(t19), .src1(t11), .z(u19));
	mux mux_s3_b18 (.sel(shamt[3]), .src0(t18), .src1(t10), .z(u18));
	mux mux_s3_b17 (.sel(shamt[3]), .src0(t17), .src1(t9), .z(u17));
	mux mux_s3_b16 (.sel(shamt[3]), .src0(t16), .src1(t8), .z(u16));
	mux mux_s3_b15 (.sel(shamt[3]), .src0(t15), .src1(t7), .z(u15));
	mux mux_s3_b14 (.sel(shamt[3]), .src0(t14), .src1(t6), .z(u14));
	mux mux_s3_b13 (.sel(shamt[3]), .src0(t13), .src1(t5), .z(u13));
	mux mux_s3_b12 (.sel(shamt[3]), .src0(t12), .src1(t4), .z(u12));
	mux mux_s3_b11 (.sel(shamt[3]), .src0(t11), .src1(t3), .z(u11));
	mux mux_s3_b10 (.sel(shamt[3]), .src0(t10), .src1(t2), .z(u10));
	mux mux_s3_b9 (.sel(shamt[3]), .src0(t9), .src1(t1), .z(u9));
	mux mux_s3_b8 (.sel(shamt[3]), .src0(t8), .src1(t0), .z(u8));
	mux mux_s3_b7 (.sel(shamt[3]), .src0(t7), .src1(LSB), .z(u7));
	mux mux_s3_b6 (.sel(shamt[3]), .src0(t6), .src1(LSB), .z(u6));
	mux mux_s3_b5 (.sel(shamt[3]), .src0(t5), .src1(LSB), .z(u5));
	mux mux_s3_b4 (.sel(shamt[3]), .src0(t4), .src1(LSB), .z(u4));
	mux mux_s3_b3 (.sel(shamt[3]), .src0(t3), .src1(LSB), .z(u3));
	mux mux_s3_b2 (.sel(shamt[3]), .src0(t2), .src1(LSB), .z(u2));
	mux mux_s3_b1 (.sel(shamt[3]), .src0(t1), .src1(LSB), .z(u1));
	mux mux_s3_b0 (.sel(shamt[3]), .src0(t0), .src1(LSB), .z(u0));

	// Build the fifth and last row of muxes (shamt 0 or 16)
	mux mux_s4_b31 (.sel(shamt[4]), .src0(u31), .src1(u15), .z(v31));
	mux mux_s4_b30 (.sel(shamt[4]), .src0(u30), .src1(u14), .z(v30));
	mux mux_s4_b29 (.sel(shamt[4]), .src0(u29), .src1(u13), .z(v29));
	mux mux_s4_b28 (.sel(shamt[4]), .src0(u28), .src1(u12), .z(v28));
	mux mux_s4_b27 (.sel(shamt[4]), .src0(u27), .src1(u11), .z(v27));
	mux mux_s4_b26 (.sel(shamt[4]), .src0(u26), .src1(u10), .z(v26));
	mux mux_s4_b25 (.sel(shamt[4]), .src0(u25), .src1(u9), .z(v25));
	mux mux_s4_b24 (.sel(shamt[4]), .src0(u24), .src1(u8), .z(v24));
	mux mux_s4_b23 (.sel(shamt[4]), .src0(u23), .src1(u7), .z(v23));
	mux mux_s4_b22 (.sel(shamt[4]), .src0(u22), .src1(u6), .z(v22));
	mux mux_s4_b21 (.sel(shamt[4]), .src0(u21), .src1(u5), .z(v21));
	mux mux_s4_b20 (.sel(shamt[4]), .src0(u20), .src1(u4), .z(v20));
	mux mux_s4_b19 (.sel(shamt[4]), .src0(u19), .src1(u3), .z(v19));
	mux mux_s4_b18 (.sel(shamt[4]), .src0(u18), .src1(u2), .z(v18));
	mux mux_s4_b17 (.sel(shamt[4]), .src0(u17), .src1(u1), .z(v17));
	mux mux_s4_b16 (.sel(shamt[4]), .src0(u16), .src1(u0), .z(v16));
	mux mux_s4_b15 (.sel(shamt[4]), .src0(u15), .src1(LSB), .z(v15));
	mux mux_s4_b14 (.sel(shamt[4]), .src0(u14), .src1(LSB), .z(v14));
	mux mux_s4_b13 (.sel(shamt[4]), .src0(u13), .src1(LSB), .z(v13));
	mux mux_s4_b12 (.sel(shamt[4]), .src0(u12), .src1(LSB), .z(v12));
	mux mux_s4_b11 (.sel(shamt[4]), .src0(u11), .src1(LSB), .z(v11));
	mux mux_s4_b10 (.sel(shamt[4]), .src0(u10), .src1(LSB), .z(v10));
	mux mux_s4_b9 (.sel(shamt[4]), .src0(u9), .src1(LSB), .z(v9));
	mux mux_s4_b8 (.sel(shamt[4]), .src0(u8), .src1(LSB), .z(v8));
	mux mux_s4_b7 (.sel(shamt[4]), .src0(u7), .src1(LSB), .z(v7));
	mux mux_s4_b6 (.sel(shamt[4]), .src0(u6), .src1(LSB), .z(v6));
	mux mux_s4_b5 (.sel(shamt[4]), .src0(u5), .src1(LSB), .z(v5));
	mux mux_s4_b4 (.sel(shamt[4]), .src0(u4), .src1(LSB), .z(v4));
	mux mux_s4_b3 (.sel(shamt[4]), .src0(u3), .src1(LSB), .z(v3));
	mux mux_s4_b2 (.sel(shamt[4]), .src0(u2), .src1(LSB), .z(v2));
	mux mux_s4_b1 (.sel(shamt[4]), .src0(u1), .src1(LSB), .z(v1));
	mux mux_s4_b0 (.sel(shamt[4]), .src0(u0), .src1(LSB), .z(v0));

	// In case shift_to_right is high, flip values back to normal. 
	// In any case, assign values to output.
	mux mux_y31 (.sel(shift_to_right), .src0(v31), .src1(v0), .z(z[31]));
	mux mux_y30 (.sel(shift_to_right), .src0(v30), .src1(v1), .z(z[30]));
	mux mux_y29 (.sel(shift_to_right), .src0(v29), .src1(v2), .z(z[29]));
	mux mux_y28 (.sel(shift_to_right), .src0(v28), .src1(v3), .z(z[28]));
	mux mux_y27 (.sel(shift_to_right), .src0(v27), .src1(v4), .z(z[27]));
	mux mux_y26 (.sel(shift_to_right), .src0(v26), .src1(v5), .z(z[26]));
	mux mux_y25 (.sel(shift_to_right), .src0(v25), .src1(v6), .z(z[25]));
	mux mux_y24 (.sel(shift_to_right), .src0(v24), .src1(v7), .z(z[24]));
	mux mux_y23 (.sel(shift_to_right), .src0(v23), .src1(v8), .z(z[23]));
	mux mux_y22 (.sel(shift_to_right), .src0(v22), .src1(v9), .z(z[22]));
	mux mux_y21 (.sel(shift_to_right), .src0(v21), .src1(v10), .z(z[21]));
	mux mux_y20 (.sel(shift_to_right), .src0(v20), .src1(v11), .z(z[20]));
	mux mux_y19 (.sel(shift_to_right), .src0(v19), .src1(v12), .z(z[19]));
	mux mux_y18 (.sel(shift_to_right), .src0(v18), .src1(v13), .z(z[18]));
	mux mux_y17 (.sel(shift_to_right), .src0(v17), .src1(v14), .z(z[17]));
	mux mux_y16 (.sel(shift_to_right), .src0(v16), .src1(v15), .z(z[16]));
	mux mux_y15 (.sel(shift_to_right), .src0(v15), .src1(v16), .z(z[15]));
	mux mux_y14 (.sel(shift_to_right), .src0(v14), .src1(v17), .z(z[14]));
	mux mux_y13 (.sel(shift_to_right), .src0(v13), .src1(v18), .z(z[13]));
	mux mux_y12 (.sel(shift_to_right), .src0(v12), .src1(v19), .z(z[12]));
	mux mux_y11 (.sel(shift_to_right), .src0(v11), .src1(v20), .z(z[11]));
	mux mux_y10 (.sel(shift_to_right), .src0(v10), .src1(v21), .z(z[10]));
	mux mux_y9 (.sel(shift_to_right), .src0(v9), .src1(v22), .z(z[9]));
	mux mux_y8 (.sel(shift_to_right), .src0(v8), .src1(v23), .z(z[8]));
	mux mux_y7 (.sel(shift_to_right), .src0(v7), .src1(v24), .z(z[7]));
	mux mux_y6 (.sel(shift_to_right), .src0(v6), .src1(v25), .z(z[6]));
	mux mux_y5 (.sel(shift_to_right), .src0(v5), .src1(v26), .z(z[5]));
	mux mux_y4 (.sel(shift_to_right), .src0(v4), .src1(v27), .z(z[4]));
	mux mux_y3 (.sel(shift_to_right), .src0(v3), .src1(v28), .z(z[3]));
	mux mux_y2 (.sel(shift_to_right), .src0(v2), .src1(v29), .z(z[2]));
	mux mux_y1 (.sel(shift_to_right), .src0(v1), .src1(v30), .z(z[1]));
	mux mux_y0 (.sel(shift_to_right), .src0(v0), .src1(v31), .z(z[0]));


endmodule