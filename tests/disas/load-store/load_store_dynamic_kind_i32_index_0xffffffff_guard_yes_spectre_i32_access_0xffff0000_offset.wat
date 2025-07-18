;;! target = "x86_64"
;;! test = "clif"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation -O static-memory-maximum-size=0 -O static-memory-guard-size=4294967295 -O dynamic-memory-guard-size=4294967295"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i32 1)

  (func (export "do_store") (param i32 i32)
    local.get 0
    local.get 1
    i32.store offset=0xffff0000)

  (func (export "do_load") (param i32) (result i32)
    local.get 0
    i32.load offset=0xffff0000))

;; function u0:0(i64 vmctx, i64, i32, i32) tail {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned gv1+16
;;     gv3 = vmctx
;;     gv4 = load.i64 notrap aligned gv3+64
;;     gv5 = load.i64 notrap aligned can_move checked gv3+56
;;     stack_limit = gv2
;;
;;                                 block0(v0: i64, v1: i64, v2: i32, v3: i32):
;; @0040                               v4 = uextend.i64 v2
;; @0040                               v5 = load.i64 notrap aligned v0+64
;; @0040                               v6 = icmp ugt v4, v5
;; @0040                               v7 = load.i64 notrap aligned can_move checked v0+56
;; @0040                               v8 = iadd v7, v4
;; @0040                               v9 = iconst.i64 0xffff_0000
;; @0040                               v10 = iadd v8, v9  ; v9 = 0xffff_0000
;; @0040                               v11 = iconst.i64 0
;; @0040                               v12 = select_spectre_guard v6, v11, v10  ; v11 = 0
;; @0040                               store little heap v3, v12
;; @0047                               jump block1
;;
;;                                 block1:
;; @0047                               return
;; }
;;
;; function u0:1(i64 vmctx, i64, i32) -> i32 tail {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned gv1+16
;;     gv3 = vmctx
;;     gv4 = load.i64 notrap aligned gv3+64
;;     gv5 = load.i64 notrap aligned can_move checked gv3+56
;;     stack_limit = gv2
;;
;;                                 block0(v0: i64, v1: i64, v2: i32):
;; @004c                               v4 = uextend.i64 v2
;; @004c                               v5 = load.i64 notrap aligned v0+64
;; @004c                               v6 = icmp ugt v4, v5
;; @004c                               v7 = load.i64 notrap aligned can_move checked v0+56
;; @004c                               v8 = iadd v7, v4
;; @004c                               v9 = iconst.i64 0xffff_0000
;; @004c                               v10 = iadd v8, v9  ; v9 = 0xffff_0000
;; @004c                               v11 = iconst.i64 0
;; @004c                               v12 = select_spectre_guard v6, v11, v10  ; v11 = 0
;; @004c                               v13 = load.i32 little heap v12
;; @0053                               jump block1
;;
;;                                 block1:
;; @0053                               return v13
;; }
