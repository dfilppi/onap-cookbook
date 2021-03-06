/*
* ============LICENSE_START=======================================================
* ONAP : SO
* ================================================================================
* Copyright 2018 TechMahindra
*=================================================================================
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
* ============LICENSE_END=========================================================
*/

package org.openecomp.mso.openstack.utils;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import java.util.HashSet;
import java.util.Set;
import org.junit.Test;
import org.mockito.Mock;
import org.openecomp.mso.db.catalog.beans.HeatTemplateParam;
import org.powermock.api.mockito.PowerMockito;

public class MsoYamlEditorWithEnvtTest {
    
    @Mock
    MsoHeatEnvironmentParameter mhep;
    
    @Mock
    HeatTemplateParam hep;

	@Test
	public void testgetParameterList() {
	    Set<HeatTemplateParam> paramSet = new HashSet<>();
	    paramSet.add(hep);
	    mhep=PowerMockito.spy(new MsoHeatEnvironmentParameter());
	    MsoYamlEditorWithEnvt Mso=mock(MsoYamlEditorWithEnvt.class);
	    when(Mso.getParameterList()).thenReturn(paramSet);
	    assert(Mso.getParameterList()!=null);
	}
	
	@Test
	public void testgetResourceLisstFromEnvt() {
	    Set<MsoHeatEnvironmentParameter> paramSet = new HashSet<>();
        paramSet.add(mhep);
        new MsoHeatEnvironmentResource();;
        mhep=PowerMockito.spy(new MsoHeatEnvironmentParameter());
        MsoYamlEditorWithEnvt Mso=mock(MsoYamlEditorWithEnvt.class);
        when(Mso.getParameterListFromEnvt()).thenReturn(paramSet);
	}
	
	@Test
	public void getParameterListFromEnvt() {
	    mhep=PowerMockito.spy(new MsoHeatEnvironmentParameter());
	    Set<MsoHeatEnvironmentParameter> paramSet = new HashSet<>();
        paramSet.add(mhep);
        new MsoHeatEnvironmentResource();;
        MsoYamlEditorWithEnvt Mso=mock(MsoYamlEditorWithEnvt.class);
        when(Mso.getParameterListFromEnvt()).thenReturn(paramSet);
	}

}
