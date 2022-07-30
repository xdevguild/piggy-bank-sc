(module
  (type (;0;) (func))
  (type (;1;) (func (result i32)))
  (type (;2;) (func (param i32)))
  (type (;3;) (func (param i32 i32 i32)))
  (type (;4;) (func (param i32 i32) (result i32)))
  (type (;5;) (func (param i32 i32)))
  (type (;6;) (func (result i64)))
  (type (;7;) (func (param i32 i32 i32) (result i32)))
  (type (;8;) (func (param i64)))
  (type (;9;) (func (param i32) (result i32)))
  (type (;10;) (func (param i32 i32 i64 i32 i32) (result i32)))
  (type (;11;) (func (param i32) (result i64)))
  (type (;12;) (func (param i32 i32 i32 i32) (result i32)))
  (import "env" "checkNoPayment" (func (;0;) (type 0)))
  (import "env" "getNumESDTTransfers" (func (;1;) (type 1)))
  (import "env" "bigIntGetCallValue" (func (;2;) (type 2)))
  (import "env" "bigIntAdd" (func (;3;) (type 3)))
  (import "env" "mBufferFromBigIntUnsigned" (func (;4;) (type 4)))
  (import "env" "mBufferStorageStore" (func (;5;) (type 4)))
  (import "env" "signalError" (func (;6;) (type 5)))
  (import "env" "getBlockTimestamp" (func (;7;) (type 6)))
  (import "env" "mBufferSetBytes" (func (;8;) (type 7)))
  (import "env" "smallIntFinishUnsigned" (func (;9;) (type 8)))
  (import "env" "bigIntFinishUnsigned" (func (;10;) (type 2)))
  (import "env" "bigIntSign" (func (;11;) (type 9)))
  (import "env" "managedTransferValueExecute" (func (;12;) (type 10)))
  (import "env" "managedCaller" (func (;13;) (type 2)))
  (import "env" "getNumArguments" (func (;14;) (type 1)))
  (import "env" "mBufferGetArgument" (func (;15;) (type 4)))
  (import "env" "mBufferGetLength" (func (;16;) (type 9)))
  (import "env" "smallIntGetUnsignedArgument" (func (;17;) (type 11)))
  (import "env" "mBufferAppendBytes" (func (;18;) (type 7)))
  (import "env" "managedSignalError" (func (;19;) (type 2)))
  (import "env" "mBufferToBigIntUnsigned" (func (;20;) (type 4)))
  (import "env" "mBufferGetByteSlice" (func (;21;) (type 12)))
  (import "env" "mBufferStorageLoad" (func (;22;) (type 4)))
  (import "env" "mBufferAppend" (func (;23;) (type 4)))
  (func (;24;) (type 0)
    call 0
    i32.const 0
    call 25)
  (func (;25;) (type 2) (param i32)
    block  ;; label = @1
      call 14
      local.get 0
      i32.ne
      br_if 0 (;@1;)
      return
    end
    i32.const 1048782
    i32.const 25
    call 6
    unreachable)
  (func (;26;) (type 0)
    (local i32 i32 i32 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 0
    global.set 0
    block  ;; label = @1
      block  ;; label = @2
        call 1
        br_if 0 (;@2;)
        i32.const 0
        call 25
        i32.const -11
        local.set 1
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load8_u offset=1048928
            local.tee 2
            i32.eqz
            br_if 0 (;@4;)
            i32.const -11
            i32.const 2147483647
            local.get 2
            select
            local.set 1
            br 1 (;@3;)
          end
          i32.const 0
          i32.const 1
          i32.store8 offset=1048928
          i32.const -11
          call 2
        end
        local.get 0
        call 27
        i32.store offset=12
        local.get 0
        i32.const 12
        i32.add
        call 28
        call 29
        br_if 1 (;@1;)
        local.get 0
        i32.const 12
        i32.add
        call 30
        call 31
        local.tee 2
        local.get 2
        local.get 1
        call 3
        local.get 0
        i32.const 12
        i32.add
        call 30
        local.set 1
        call 32
        local.tee 3
        local.get 2
        call 4
        drop
        local.get 1
        local.get 3
        call 5
        drop
        local.get 0
        i32.const 16
        i32.add
        global.set 0
        return
      end
      i32.const 1048807
      i32.const 37
      call 6
      unreachable
    end
    i32.const 1048636
    i32.const 40
    call 33
    unreachable)
  (func (;27;) (type 1) (result i32)
    (local i32)
    call 32
    local.tee 0
    call 13
    local.get 0)
  (func (;28;) (type 9) (param i32) (result i32)
    (local i32)
    i32.const 1048749
    i32.const 8
    call 46
    local.tee 1
    local.get 0
    i32.load
    call 47
    local.get 1)
  (func (;29;) (type 9) (param i32) (result i32)
    local.get 0
    i32.const -25
    call 22
    drop
    i32.const -25
    call 16
    i32.eqz)
  (func (;30;) (type 9) (param i32) (result i32)
    (local i32)
    i32.const 1048737
    i32.const 12
    call 46
    local.tee 1
    local.get 0
    i32.load
    call 47
    local.get 1)
  (func (;31;) (type 9) (param i32) (result i32)
    local.get 0
    call 50
    call 32
    local.tee 0
    call 20
    drop
    local.get 0)
  (func (;32;) (type 1) (result i32)
    (local i32)
    i32.const 0
    i32.const 0
    i32.load offset=1048924
    i32.const -1
    i32.add
    local.tee 0
    i32.store offset=1048924
    local.get 0)
  (func (;33;) (type 5) (param i32 i32)
    local.get 0
    local.get 1
    call 48
    unreachable)
  (func (;34;) (type 0)
    (local i32 i64 i32 i32 i32 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 0
    global.set 0
    call 0
    i32.const 1
    call 25
    call 35
    local.set 1
    local.get 0
    call 27
    i32.store offset=4
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.const 4
          i32.add
          call 28
          call 29
          i32.eqz
          br_if 0 (;@3;)
          call 7
          local.get 1
          i64.ge_u
          br_if 1 (;@2;)
          local.get 0
          i32.const 4
          i32.add
          call 28
          local.set 2
          local.get 0
          local.get 1
          i64.const 56
          i64.shl
          local.get 1
          i64.const 40
          i64.shl
          i64.const 71776119061217280
          i64.and
          i64.or
          local.get 1
          i64.const 24
          i64.shl
          i64.const 280375465082880
          i64.and
          local.get 1
          i64.const 8
          i64.shl
          i64.const 1095216660480
          i64.and
          i64.or
          i64.or
          local.get 1
          i64.const 8
          i64.shr_u
          i64.const 4278190080
          i64.and
          local.get 1
          i64.const 24
          i64.shr_u
          i64.const 16711680
          i64.and
          i64.or
          local.get 1
          i64.const 40
          i64.shr_u
          i64.const 65280
          i64.and
          local.get 1
          i64.const 56
          i64.shr_u
          i64.or
          i64.or
          i64.or
          i64.store offset=8
          i32.const 0
          local.set 3
          loop  ;; label = @4
            local.get 3
            i32.const 8
            i32.eq
            br_if 3 (;@1;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.const 8
                i32.add
                local.get 3
                i32.add
                local.tee 4
                i32.load8_u
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.const 9
                i32.lt_u
                br_if 1 (;@5;)
                local.get 3
                call 36
                unreachable
              end
              local.get 3
              i32.const 1
              i32.add
              local.set 3
              br 1 (;@4;)
            end
          end
          call 32
          local.tee 5
          local.get 4
          i32.const 8
          local.get 3
          i32.sub
          call 8
          drop
          local.get 2
          local.get 5
          call 5
          drop
          local.get 0
          i32.const 16
          i32.add
          global.set 0
          return
        end
        i32.const 1048576
        i32.const 26
        call 33
        unreachable
      end
      i32.const 1048602
      i32.const 34
      call 33
      unreachable
    end
    call 37
    unreachable)
  (func (;35;) (type 6) (result i64)
    i32.const 0
    call 17)
  (func (;36;) (type 2) (param i32)
    call 52
    unreachable)
  (func (;37;) (type 0)
    call 52
    unreachable)
  (func (;38;) (type 0)
    (local i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 0
    global.set 0
    call 0
    i32.const 1
    call 25
    local.get 0
    call 39
    i32.store offset=12
    local.get 0
    i32.const 12
    i32.add
    call 28
    call 40
    call 9
    local.get 0
    i32.const 16
    i32.add
    global.set 0)
  (func (;39;) (type 1) (result i32)
    (local i32)
    i32.const 0
    call 32
    local.tee 0
    call 15
    drop
    block  ;; label = @1
      local.get 0
      call 16
      i32.const 32
      i32.eq
      br_if 0 (;@1;)
      call 49
      unreachable
    end
    local.get 0)
  (func (;40;) (type 11) (param i32) (result i64)
    (local i32 i64 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 1
    global.set 0
    i64.const 0
    local.set 2
    local.get 1
    i64.const 0
    i64.store offset=8
    block  ;; label = @1
      local.get 0
      call 50
      local.tee 3
      call 16
      local.tee 0
      i32.const 9
      i32.ge_u
      br_if 0 (;@1;)
      local.get 3
      i32.const 0
      local.get 0
      local.get 1
      i32.const 8
      i32.add
      call 21
      drop
      block  ;; label = @2
        local.get 0
        i32.eqz
        br_if 0 (;@2;)
        i64.const 0
        local.set 2
        local.get 1
        i32.const 8
        i32.add
        local.set 3
        loop  ;; label = @3
          local.get 0
          i32.eqz
          br_if 1 (;@2;)
          local.get 0
          i32.const -1
          i32.add
          local.set 0
          local.get 2
          i64.const 8
          i64.shl
          local.get 3
          i64.load8_u
          i64.or
          local.set 2
          local.get 3
          i32.const 1
          i32.add
          local.set 3
          br 0 (;@3;)
        end
      end
      local.get 1
      i32.const 16
      i32.add
      global.set 0
      local.get 2
      return
    end
    call 51
    unreachable)
  (func (;41;) (type 0)
    (local i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 0
    global.set 0
    call 0
    i32.const 1
    call 25
    local.get 0
    call 39
    i32.store offset=12
    local.get 0
    i32.const 12
    i32.add
    call 30
    call 31
    call 10
    local.get 0
    i32.const 16
    i32.add
    global.set 0)
  (func (;42;) (type 0)
    (local i32 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 0
    global.set 0
    call 0
    i32.const 0
    call 25
    local.get 0
    call 27
    local.tee 1
    i32.store offset=12
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 12
        i32.add
        call 28
        call 40
        call 7
        i64.ge_u
        br_if 0 (;@2;)
        local.get 0
        i32.const 12
        i32.add
        call 30
        call 31
        call 11
        i32.const 0
        i32.le_s
        br_if 1 (;@1;)
        local.get 1
        local.get 0
        i32.const 12
        i32.add
        call 30
        call 31
        i64.const 0
        call 43
        call 43
        call 12
        drop
        local.get 0
        i32.const 12
        i32.add
        call 30
        call 44
        local.get 0
        i32.const 12
        i32.add
        call 28
        call 44
        local.get 0
        i32.const 16
        i32.add
        global.set 0
        return
      end
      i32.const 1048676
      i32.const 33
      call 33
      unreachable
    end
    i32.const 1048709
    i32.const 28
    call 33
    unreachable)
  (func (;43;) (type 1) (result i32)
    (local i32)
    call 32
    local.tee 0
    i32.const 1048908
    i32.const 0
    call 8
    drop
    local.get 0)
  (func (;44;) (type 2) (param i32)
    i32.const -20
    i32.const 0
    i32.const 0
    call 8
    drop
    local.get 0
    i32.const -20
    call 5
    drop)
  (func (;45;) (type 0))
  (func (;46;) (type 4) (param i32 i32) (result i32)
    (local i32)
    call 32
    local.tee 2
    local.get 0
    local.get 1
    call 8
    drop
    local.get 2)
  (func (;47;) (type 5) (param i32 i32)
    local.get 0
    local.get 1
    call 23
    drop)
  (func (;48;) (type 5) (param i32 i32)
    local.get 0
    local.get 1
    call 6
    unreachable)
  (func (;49;) (type 0)
    (local i32)
    i32.const 1048844
    i32.const 23
    call 46
    local.tee 0
    i32.const 1048757
    i32.const 11
    call 18
    drop
    local.get 0
    i32.const 1048867
    i32.const 3
    call 18
    drop
    local.get 0
    i32.const 1048892
    i32.const 16
    call 18
    drop
    local.get 0
    call 19
    unreachable)
  (func (;50;) (type 9) (param i32) (result i32)
    (local i32)
    local.get 0
    call 32
    local.tee 1
    call 22
    drop
    local.get 1)
  (func (;51;) (type 0)
    (local i32)
    i32.const 1048870
    i32.const 22
    call 46
    local.tee 0
    i32.const 1048768
    i32.const 14
    call 18
    drop
    local.get 0
    call 19
    unreachable)
  (func (;52;) (type 0)
    call 53
    unreachable)
  (func (;53;) (type 0)
    i32.const 1048908
    i32.const 14
    call 6
    unreachable)
  (memory (;0;) 17)
  (global (;0;) (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1048929))
  (global (;2;) i32 (i32.const 1048944))
  (export "memory" (memory 0))
  (export "init" (func 24))
  (export "addAmount" (func 26))
  (export "createPiggy" (func 34))
  (export "getLockTime" (func 38))
  (export "getLockedAmount" (func 41))
  (export "payOut" (func 42))
  (export "callBack" (func 45))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2))
  (data (;0;) (i32.const 1048576) "You already have one piggyLock time should be in the future!You need to create your piggy bank firstYou can't withdraw your money yetThere is nothing to withdrawlockedAmountlockTimepiggy_ownerinput too longwrong number of argumentsfunction does not accept ESDT paymentargument decode error (): storage decode error: bad array lengthpanic occurred")
  (data (;1;) (i32.const 1048924) "\9c\ff\ff\ff"))
