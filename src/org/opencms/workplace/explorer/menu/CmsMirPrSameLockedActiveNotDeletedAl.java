/*
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (c) Alkacon Software GmbH & Co. KG (http://www.alkacon.com)
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
 * For further information about Alkacon Software GmbH & Co. KG, please see the
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
import org.opencms.lock.CmsLock;
import org.opencms.main.OpenCms;
import org.opencms.workplace.explorer.CmsResourceUtil;

/**
 * Defines a menu item rule that sets the visibility to active if the current resource is not deleted or inactive
 * if the current resource is deleted and locked by the current user.<p>
 *
 * @since 6.5.6
 */
public class CmsMirPrSameLockedActiveNotDeletedAl extends A_CmsMenuItemRule {

    /**
     * @see org.opencms.workplace.explorer.menu.I_CmsMenuItemRule#getVisibility(org.opencms.file.CmsObject, CmsResourceUtil[])
     */
    @Override
    public CmsMenuItemVisibilityMode getVisibility(CmsObject cms, CmsResourceUtil[] resourceUtil) {

        if (resourceUtil[0].getResource().getState().isDeleted() || !resourceUtil[0].isEditable()) {
            return CmsMenuItemVisibilityMode.VISIBILITY_INACTIVE.addMessageKey(
                Messages.GUI_CONTEXTMENU_TITLE_INACTIVE_DELETED_0);
        }
        return CmsMenuItemVisibilityMode.VISIBILITY_ACTIVE;
    }

    /**
     * @see org.opencms.workplace.explorer.menu.I_CmsMenuItemRule#matches(org.opencms.file.CmsObject, CmsResourceUtil[])
     */
    public boolean matches(CmsObject cms, CmsResourceUtil[] resourceUtil) {

        if (resourceUtil[0].isInsideProject()) {
            CmsLock lock = resourceUtil[0].getLock();
            boolean lockedForPublish = resourceUtil[0].getProjectState().isLockedForPublishing();
            return (!lockedForPublish
                && !lock.isShared()
                && lock.isOwnedInProjectBy(
                    cms.getRequestContext().getCurrentUser(),
                    cms.getRequestContext().getCurrentProject()))
                || (!lockedForPublish && lock.isNullLock() && OpenCms.getWorkplaceManager().autoLockResources());
        }
        // resource is not locked by the user in current project or not locked with enabled autolock, rule does not match
        return false;
    }

}
