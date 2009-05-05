package com.talk;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.stream.IBroadcastStream;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;

public class Application extends ApplicationAdapter {
    
    private static final Log log = LogFactory.getLog(Application.class);

    public boolean connect(IConnection conn, IScope scope, Object[] params) {
        log.debug("Talk connect for: " + conn.getScope().getContextPath());
        return super.connect(conn, scope, params);
    }
    public void disconnect(IConnection conn, IScope scope) {
        log.debug("Talk disconnect for: " + conn.getScope().getContextPath());
        super.disconnect(conn, scope);
    }
    /*public void streamPublishStart(IBroadcastStream stream) {
        log.debug("streamPublishStart");
        super.streamPublishStart(stream);
    }*/
}

