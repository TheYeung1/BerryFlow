/* Copyright (c) 2012 Research In Motion Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "InviteToDownload.hpp"

#include "RegistrationHandler.hpp"

#include <bb/cascades/AbstractPane>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>

#include <bb/platform/bbm/MessageService>

using namespace bb::cascades;

InviteToDownload::InviteToDownload(bb::platform::bbm::Context &context, QObject *parent)
    : QObject(parent)
    , m_messageService(0)
    , m_context(&context)
{
}

void InviteToDownload::sendInvite()
{
    if (!m_messageService) {
        // Instantiate the MessageService.
        m_messageService = new bb::platform::bbm::MessageService(m_context, this);
    }
    // Trigger the invite to download process.
    m_messageService->sendDownloadInvitation();
}
