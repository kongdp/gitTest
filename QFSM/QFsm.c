/*
 * ***************************************************************************
 * PROJECT     : leetcode
 * FILE NAME   : QFsm.c
 * CREATE DATE : 2019-01-21
 * AUTHOR      : kevin
 * VERSION     : V1.0
 * DESCRIPISION: 
 * ---------------------------------------------------------------------------
 * Copyright SHANDONG CONTACT COMMUNICATION TECHNOLOGY L.T.D
 * ---------------------------------------------------------------------------
 * HISTORY:
 * Date        By     Comments
 * ----------  -----  --------------------------------------------------------
 * ***************************************************************************
 */


#include <stdio.h>
#include <stdlib.h>

typedef unsigned char uint8 ;
typedef uint8     QSignal;
typedef uint8     QState;

typedef struct QEventTag{
    QSignal sig;
    uint8 dynamic;
}QEvent;

/* 定义时间处理函数类型 */
typedef QState (*QStateHandler)(void *me, QEvent const *e);

/* QFsm状态机定义 */
typedef struct QFsmTag{
    QStateHandler state;
}QFsm;

#define QFsm_ctor(me_, initial_) ((me_)->state = (initial_))

#define Q_RET_HANDLED ((QState)0)

#define Q_RET_IGNORED ((QState)1)

#define Q_RET_TRAN    ((QState)2)

#define Q_HANDLED()    (Q_RET_HANDLED)

#define Q_IGNORED()    (Q_RET_IGNORED)


/* 保留信号 */
enum QReservedSignals{
    Q_ENTRY_SIG = 1,
    Q_EXIT_SIG,
    Q_INIT_SIG,
    Q_USER_SIG
};

/* 状态转换宏定义 */
//#define Q_TRAN(target_)   (((QFsm*)me)->state = (QStateHandler)(target_), Q_RET_TRAN)

QState QTranlage(QFsm *me, QStateHandler target)
{
    me->state = (QStateHandler)target;
    return Q_RET_TRAN;
}

#define Q_TRAN(me, target) QTranlage((QFsm*)me,  (QStateHandler)target)


/* 时间 */
 const QEvent  QEP_reservedEvt_[] = {
    {(QSignal)Q_ENTRY_SIG, (uint8)0},
    {(QSignal)Q_EXIT_SIG, (uint8)0},
    {(QSignal)Q_INIT_SIG,  (uint8)0},
    {(QSignal)Q_USER_SIG,  (uint8)0}
};

/*******************************************************************************
Func Name   : QFsm_init
Description : 状态机初始化
Input(s)    : me 状态
              e  事件
Output(s)   : 
Return      : 
Others      :
------------------------------------------------------------------------------
History
Date(yyyy-mm-dd)     Author        Modification
2019-01-21           kongdepeng    Created
*******************************************************************************/
void QFsm_init(QFsm *me,const QEvent  *e)
{
    /* 执行初始化转换 */
    (*me->state)(me, e);

    /* 进入目标 */
    (void)(*me->state)(me, &QEP_reservedEvt_[Q_ENTRY_SIG]);
}

/*******************************************************************************
Func Name   : QFsm_dispatch
Description : 调度器(事件处理器)
Input(s)    : me 状态
              e  事件
Output(s)   : 
Return      : 
Others      :
------------------------------------------------------------------------------
History
Date(yyyy-mm-dd)     Author        Modification
2019-01-21           kongdepeng    Created
*******************************************************************************/
void QFsm_dispatch(QFsm *me, const QEvent *e)
{
    /* 保存当前状态 */
    QStateHandler s = me->state;
    /* 调用事件处理器 */
    QState r = (*s)(me, e);

    /* 如果发生状态的转换 */
    if(r == Q_RET_TRAN)
    {
        /* 1、处理上一个状态的退出 (last exit) */
        (void)(*s)(me, &QEP_reservedEvt_[Q_EXIT_SIG]);

        /* 2、执行当前状态的进入 (current enter) */
        (void)(*me->state)(me, &QEP_reservedEvt_[Q_ENTRY_SIG]);
    }
}

/***************************************** 以下为应用程序  *******************************************/

enum BombSignals{
    UP_SIG = Q_USER_SIG, /* 从用户信号量开始 */
    DOWN_SIG,
    ARM_SIG,
    TICK_SIG
};

/* 派生出时间事件 */
typedef struct TickEvtTag{
    QEvent super;
    uint8 fine_time;
}TickEvt;

/* 派生出 应用主结构体 */
typedef struct Bomb4Tag{
    QFsm super;
    uint8 timeout;
    uint8 code;
    uint8 defuse;
}Bomb4;

/* 事件函数列表 */
void Bomb4_ctor(Bomb4 *me, uint8 defuse);
QState Bomb4_initial(Bomb4 *me, QEvent const *e);
QState Bomb4_setting(Bomb4 *me, QEvent const *e);
QState Bomb4_timing(Bomb4 *me, QEvent const *e);

/* 空应用 */
#define BSP_display(x)
#define BSP_boom()


#define INIT_TIMEOUT 10

/*******************************************************************************
Func Name   : Bomb4_ctor
Description : 构造函数
Input(s)    : me 状态
              defuse   密码
Output(s)   : 
Return      : 
Others      :
------------------------------------------------------------------------------
History
Date(yyyy-mm-dd)     Author        Modification
2019-01-21           kongdepeng    Created
*******************************************************************************/
void Bomb4_ctor(Bomb4 *me, uint8 defuse)
{
    //QFsm_ctor_(&(me->super), (QStateHandler)&Bomb4_initial);
    me->defuse = defuse;
}


/*******************************************************************************
Func Name   : Bomb4_initial
Description : 初始化
Input(s)    : me 状态
              e  事件
Output(s)   : 
Return      : 
Others      :
------------------------------------------------------------------------------
History
Date(yyyy-mm-dd)     Author        Modification
2019-01-21           kongdepeng    Created
*******************************************************************************/
QState Bomb4_initial(Bomb4 *me, QEvent const *e)
{
    (void)e;
    me->timeout = INIT_TIMEOUT;
    return Q_TRAN(me, &Bomb4_setting);
}

/*******************************************************************************
Func Name   : Bomb4_setting
Description : 设置态
Input(s)    : me 状态
              e  事件
Output(s)   : 
Return      : 
Others      :
------------------------------------------------------------------------------
History
Date(yyyy-mm-dd)     Author        Modification
2019-01-21           kongdepeng    Created
*******************************************************************************/
QState Bomb4_setting(Bomb4 *me, QEvent const *e)
{
    switch(e->sig)
    {
        case UP_SIG:
        {
            if(me->timeout < 60)
            {
                ++me->timeout;
                BSP_display(me->timeout);
            }
            return Q_HANDLED();
        }

        case DOWN_SIG:
        {
            if(me->timeout > 1)
            {
                --me->timeout;
                BSP_display(me->timeout);
            }
            return Q_HANDLED();
        }

        case ARM_SIG:
        {
            return Q_TRAN(me, &Bomb4_timing);
        }
    }

    return Q_IGNORED();
}

/*******************************************************************************
Func Name   : Bomb4_setting
Description : 设置态
Input(s)    : me 状态
              e  事件
Output(s)   : 
Return      : 
Others      :
------------------------------------------------------------------------------
History
Date(yyyy-mm-dd)     Author        Modification
2019-01-21           kongdepeng    Created
*******************************************************************************/
QState Bomb4_timing(Bomb4 *me, QEvent const *e)
{
    switch(e->sig)
    {
        case Q_ENTRY_SIG:
        {
            me->code = 0;
            return Q_HANDLED();
        }

        case UP_SIG:
        {
            me->code <<= 1;
            me->code |= 1;
            return Q_HANDLED();
        }

        case DOWN_SIG:
        {
            me->code <<= 1;
            return Q_HANDLED();
        }

        case ARM_SIG:
        {
            if(me->code == me->defuse)
            {
                return Q_TRAN(me, Bomb4_setting);
            }
            return Q_HANDLED();
        }

        case TICK_SIG:
        {
            if(((TickEvt const *)e)->fine_time == 0)
            {
                --me->timeout;
                BSP_display(me->timeout);
                if(me->timeout == 0)
                {
                    BSP_boom();
                }
            }

            return Q_HANDLED();
        }
    }

    return Q_IGNORED();
}







static int a = 4;
int main()
{
    int *p = &a;
    printf("just test QFsm %d, %d", p,&p);

    while(1);
    return 0;
}