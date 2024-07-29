/*
 * @File     : event_bus
 * @Author   : jade
 * @Date     : 2024/07/19 10:24:41
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:event_bus/event_bus.dart';

class EventBusUtil {
  static final EventBusUtil instance = EventBusUtil._internal();
  static  EventBus eventBus =  EventBus();
 
  factory EventBusUtil() => instance;
 
  EventBusUtil._internal();
 


  EventBus getDefaultEvent(){
    return eventBus;
  }
}



