package com.example.drama_source_app
import android.content.Context
import com.github.catvod.crawler.Spider
import com.github.catvod.crawler.SpiderNull
import dalvik.system.DexClassLoader
import java.io.File
import java.util.concurrent.Future
import kotlin.concurrent.thread

class JarSpider(ext:String,api: String,context: Context,jarFilePath: String) {
    // 属性定义
    private var _spider: Spider = SpiderNull()
    private  var _dexClassLoader:DexClassLoader
    private  var _context:Context
    private var _ext:String

    private fun loadJarFromDexClassLoader(context: Context, jarFilePath: String): DexClassLoader {
        // 指定JAR文件和代码缓存目录
        val jarFile = File(jarFilePath)
        val dexOutputDir = context.codeCacheDir // 或者其他合适的目录
        val dexClassLoader = DexClassLoader(jarFile.absolutePath, dexOutputDir.absolutePath, null, context.classLoader)
        return dexClassLoader;
    }



    private  fun getSpider(api: String, ext: String, dexClassLoader: DexClassLoader,context: Context): Spider {
        try {
            val spider =  dexClassLoader.loadClass( "com.github.catvod.spider." + api.split("csp_".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()[1]).newInstance() as Spider
            println("com.github.catvod.spider." + api.split("csp_".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()[1])
            return spider
        } catch (e: Throwable) {
            e.printStackTrace()
            return SpiderNull()
        }
    }

    init {
        _dexClassLoader = loadJarFromDexClassLoader(context,jarFilePath)
        _spider = getSpider(api,ext,_dexClassLoader,context)
        _context = context
        _ext = ext

    }

    fun  homeContent(boolean: Boolean):String{
        _spider.init(_context,_ext)
        val result = _spider.homeContent(boolean)
        _spider.destroy()
        _dexClassLoader.clearAssertionStatus()
        return result
    }


    fun  homeVideoContent():String{
        _spider.init(_context,_ext)
        val result = _spider.homeVideoContent()
        _spider.destroy()
        _dexClassLoader.clearAssertionStatus()
        return result
    }

}

