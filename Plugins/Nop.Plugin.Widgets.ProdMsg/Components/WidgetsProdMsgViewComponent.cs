using Microsoft.AspNetCore.Mvc;
using Nop.Core;
using Nop.Core.Caching;
using Nop.Plugin.Widgets.ProdMsg.Infrastructure.Cache;
using Nop.Plugin.Widgets.ProdMsg.Models;
using Nop.Services.Configuration;
using Nop.Services.Media;
using Nop.Web.Framework.Components;

namespace Nop.Plugin.Widgets.ProdMsg.Components
{
    [ViewComponent(Name = "WidgetsProdMsg")]
    public class WidgetsProdMsgViewComponent : NopViewComponent
    {
        private readonly IStoreContext _storeContext;
        private readonly IStaticCacheManager _cacheManager;
        private readonly ISettingService _settingService;
        private readonly IPictureService _pictureService;

        public WidgetsProdMsgViewComponent(IStoreContext storeContext, 
            IStaticCacheManager cacheManager, 
            ISettingService settingService, 
            IPictureService pictureService)
        {
            this._storeContext = storeContext;
            this._cacheManager = cacheManager;
            this._settingService = settingService;
            this._pictureService = pictureService;
        }

        public IViewComponentResult Invoke(string widgetZone, object additionalData)
        {
            var ProdMsgSettings = _settingService.LoadSetting<ProdMsgSettings>(_storeContext.CurrentStore.Id);

            var model = new PublicInfoModel
            {
                Message = ProdMsgSettings.Message
            };

            if (string.IsNullOrEmpty(model.Message))
                //no text found
                return Content("");

            return View("~/Plugins/Widgets.ProdMsg/Views/PublicInfo.cshtml", model);
        }


    }
}
