/*
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (C) Alkacon Software (http://www.alkacon.com)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * For further information about Alkacon Software, please see the
 * company website: http://www.alkacon.com
 *
 * For further information about OpenCms, please see the
 * project website: http://www.opencms.org
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package org.opencms.workplace.explorer.menu;

import org.opencms.file.CmsObject;
import org.opencms.main.OpenCms;
import org.opencms.site.CmsSite;
import org.opencms.workplace.explorer.CmsResourceUtil;

/**
 * Menu item rule for deactivating options for resources in a different real site.<p>
 */
public class CmsMirOtherSiteInactive extends A_CmsMenuItemRule {

    /**
     * @see org.opencms.workplace.explorer.menu.I_CmsMenuItemRule#getVisibility(org.opencms.file.CmsObject, CmsResourceUtil[])
     */
    @Override
    public CmsMenuItemVisibilityMode getVisibility(CmsObject cms, CmsResourceUtil[] resourceUtil) {

        return CmsMenuItemVisibilityMode.VISIBILITY_INACTIVE.addMessageKey(
            Messages.GUI_CONTEXTMENU_TITLE_OTHER_SITE_INACTIVE_0);
    }

    /**
     * @see org.opencms.workplace.explorer.menu.I_CmsMenuItemRule#matches(org.opencms.file.CmsObject, org.opencms.workplace.explorer.CmsResourceUtil[])
     */
    public boolean matches(CmsObject cms, CmsResourceUtil[] resourceUtil) {

        CmsSite currentSite = OpenCms.getSiteManager().getSiteForRootPath(cms.getRequestContext().getSiteRoot());
        CmsSite resourceSite = OpenCms.getSiteManager().getSiteForRootPath(resourceUtil[0].getResource().getRootPath());
        return (currentSite != null) && (resourceSite != null) && (currentSite != resourceSite);
    }

}
