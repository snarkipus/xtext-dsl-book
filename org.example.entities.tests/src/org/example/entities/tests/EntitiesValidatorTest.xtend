package org.example.entities.tests

import org.junit.Test
import org.junit.runner.RunWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.InjectWith
import com.google.inject.Inject
import org.eclipse.xtext.testing.util.ParseHelper
import org.example.entities.entities.Model
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.example.entities.entities.EntitiesPackage
import org.example.entities.validation.EntitiesValidator

@RunWith(XtextRunner)
@InjectWith(EntitiesInjectorProvider)
class EntitiesValidatorTest {
	
	@Inject extension ParseHelper<Model>
	@Inject extension ValidationTestHelper
	
	@Test
	def void testEntityExtendsItself() {
		'''
			entity MyEntity extends MyEntity {
				
			}
		'''.parse.assertCycleInHierarchy("MyEntity")
	}
	
	def private assertCycleInHierarchy(Model m, String entityName) {
		m.assertError(
			EntitiesPackage.eINSTANCE.entity,
			EntitiesValidator.HIERARCHY_CYCLE,
			"cycle in hierarchy of entity '"+ entityName +"'"
		)
	}
	
	@Test
	def void testCycleInEntityHierarchy() {
		'''
			entity A extends B {}
			entity B extends C {}
			entity C extends A {}
		'''.parse => [
			assertCycleInHierarchy("A")
			assertCycleInHierarchy("B")
			assertCycleInHierarchy("C")
		]
	}
	
	@Test
	def void testCycleInHierarchyErrorPosition() {
		val testInput = 
		'''
			entity MyEntity extends MyEntity {
			}
		'''
		testInput.parse.assertError(
			EntitiesPackage.eINSTANCE.entity,
			EntitiesValidator.HIERARCHY_CYCLE,
			testInput.lastIndexOf("MyEntity"), // offset
			"MyEntity".length
		)
	}
	
	@Test
	def void testValidHierarchy() {
		'''
			entity FirstEntity {}
			entity SecondEntity extends FirstEntity {}
		'''.parse.assertNoErrors
	}
}