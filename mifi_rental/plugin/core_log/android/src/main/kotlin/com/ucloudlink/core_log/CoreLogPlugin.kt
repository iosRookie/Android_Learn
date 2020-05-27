package com.ucloudlink.core_log

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** CoreLogPlugin */
public class CoreLogPlugin: FlutterPlugin, MethodCallHandler {
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "core_log")
    channel.setMethodCallHandler(CoreLogPlugin());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "core_log")
      channel.setMethodCallHandler(CoreLogPlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "v", "d", "i", "w", "e", "a" -> {
        call.arguments?.run {
          prepareLog(call.method, this)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }

  private fun prepareLog(method: String, arguments: Any) {
    val map: HashMap<*, *>? =
            if (arguments is HashMap<*, *>) {
              arguments
            } else {
              null
            }
    map?.let {
      checkNotNull(it["tag"], it["message"]) { tag, message ->
        if (tag is String && message is String) {
          log(method, tag, message)
        }
      }
    }
  }

  private fun log(method: String, tag: String, message: String) {
    when (method) {
      "v" -> ULog.v(tag, message)
      "d" -> ULog.d(tag, message)
      "i" -> ULog.i(tag, message)
      "w" -> ULog.w(tag, message)
      "e" -> ULog.e(tag, message)
      "a" -> ULog.a(tag, message)
    }
  }
}
